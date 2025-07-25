let cursorWidth = 10;
let cursorHeight = 20;
let mode = "click";
let masterCanvas;
const INTERVAL = 1000;
let intervalId = undefined;
function changeCursorType(x, y) {
  cursorWidth = x;
  cursorHeight = y;
}
let wrapShader = undefined;

let config = JSON.parse(localStorage.getItem("config")) || {
  canvas: ["cursor_blaze.glsl", "debug_cursor_static.glsl"],
  cursorColor: [1, 0, 0, 1],
};

function hexToRgbNormalized(hex) {
  let r = parseInt(hex.substr(1, 2), 16) / 255;
  let g = parseInt(hex.substr(3, 2), 16) / 255;
  let b = parseInt(hex.substr(5, 2), 16) / 255;
  return [r, g, b, 1];
}
const cursorColorInput = document.getElementById("cursorColor");
cursorColorInput.addEventListener("input", () => {
  const hex = cursorColorInput.value;
  config.cursorColor = hexToRgbNormalized(hex);
});

function changeMode(_mode) {
  mode = _mode;
  if (intervalId) {
    clearInterval(intervalId);
  }
  switch (_mode) {
    case "auto":
      intervalId = setInterval(() => {
        changePresetPosition(1);
      }, INTERVAL);
      break;
    case "rnd":
      intervalId = setInterval(() => {
        randomCursor();
      }, INTERVAL);
      break;
    case "click":
      break;
  }
}

const playground = document.getElementById("playground");
let sandboxes = [];
window.addEventListener("resize", function () {
  setGrid();
});

function setGrid() {
  const isVertical = window.innerHeight > window.innerWidth;
  const playground = document.getElementById("playground");
  if (!playground) {
    return;
  }
  let value = sandboxes.reduce((a, b) => a + " 1fr", "");
  console.log(value);

  if (isVertical) {
    playground.style.gridTemplateColumns = "unset";
    playground.style.gridTemplateRows = value;
  } else {
    playground.style.gridTemplateColumns = value;
    playground.style.gridTemplateRows = "unset";
  }
}
let previousCursor = { x: 0, y: 0, z: 10, w: 20 };
let currentCursor = { x: 0, y: 0, z: 10, w: 20 };
let option = 0;
Promise.all([
  fetch("ghostty_wrapper.glsl").then((response) => response.text()),
  fetch("/shaders-list").then((response) => response.json()),
]).then(([ghosttyWrapper, list]) => {
  wrapShader = (shader) => ghosttyWrapper.replace("//$REPLACE$", shader);
  config.canvas.forEach((shader, index) => {
    const sandbox = init(index, shader, list);
    sandboxes.push(sandbox);
  });
  setGrid();
});

async function fetchShaders() {
  const response = await fetch("/shaders-list");
  return await response.json();
}

function init(index, shader, list) {
  const canvasWrapper = document.createElement("div");
  canvasWrapper.className = "_canvas-wrapper";

  const selectMenu = document.createElement("select");
  const shaders = list;

  shaders.forEach((shader) => {
    const option = document.createElement("option");
    option.value = shader; // Assuming shader has an 'id' property
    option.textContent = shader; // Assuming shader has a 'name' property
    selectMenu.appendChild(option);
  });

  canvasWrapper.appendChild(selectMenu);

  const canvas = document.createElement("canvas");
  canvasWrapper.appendChild(canvas);
  playground.appendChild(canvasWrapper);
  canvas.width = canvasWrapper.clientWidth;
  canvas.height = canvasWrapper.clientHeight;
  const sandbox = new GlslCanvas(canvas);
  canvas.addEventListener("click", (event) => {
    if (mode != "click") {
      return;
    }
    const rect = canvas.getBoundingClientRect();
    const x = event.clientX - rect.left;
    const y = canvas.height - (event.clientY - rect.top);
    console.log(x, y);
    moveCursor(x, y);
    setCursorUniforms();
  });
  masterCanvas = canvas;

  selectMenu.addEventListener("change", (event) => {
    const selectedShader = event.target.value;
    config.canvas[index] = selectedShader;
    fetch(`shaders/${selectedShader}`)
      .then((response) => {
        return response.text();
      })
      .then((shaderCode) => {
        let newShader = wrapShader(shaderCode);
        sandbox.load(newShader);
        localStorage.setItem("config", JSON.stringify(config));
      });
  });
  selectMenu.value = shader;
  selectMenu.dispatchEvent(new Event("change"));
  return sandbox;
}

//
function setCursorUniforms() {
  sandboxes.forEach((sandbox) => {
    sandbox.setUniform(
      "iCurrentCursor",
      currentCursor.x,
      currentCursor.y,
      currentCursor.z,
      currentCursor.w,
    );
    sandbox.setUniform(
      "iPreviousCursor",
      previousCursor.x,
      previousCursor.y,
      previousCursor.z,
      previousCursor.w,
    );
    sandbox.setUniform(
      "iCurrentCursorColor",
      config.cursorColor[0],
      config.cursorColor[1],
      config.cursorColor[2],
      config.cursorColor[3],
    );
    let now = sandbox.uniforms["u_time"].value[0];
    sandbox.setUniform("iTimeCursorChange", now);
  });
}
function randomCursor() {
  const x = Math.random() * masterCanvas.width;
  const y = Math.random() * masterCanvas.height;
  moveCursor(x, y);
  setCursorUniforms();
}
document.addEventListener("keydown", function (event) {
  if (event.key) {
    let increment = { x: 0, y: 0 };
    switch (event.key) {
      case "Enter":
      case "ArrowDown":
        increment.y = -20;
        break;
      case "ArrowLeft":
      case "Backspace":
        increment.x = -10;
        break;
      case "ArrowUp":
        increment.y = 20;
        break;
      default:
        increment.x = 10;
        break;
    }

    // You can specify a specific key if needed
    moveCursor(currentCursor.x + increment.x, currentCursor.y + increment.y);
    setCursorUniforms();
  }
});
function moveCursor(x, y) {
  previousCursor = { ...currentCursor };
  currentCursor = {
    x: x,
    y: y,
    z: cursorWidth,
    w: cursorHeight,
  };
}
document.addEventListener("click", function () {
  if (mode != "auto") {
    return;
  }
  changePresetPosition(1);
});

document.addEventListener("contextmenu", function (event) {
  event.preventDefault(); // Prevent default context menu from appearing
  if (mode != "auto") {
    return;
  }
  changePresetPosition(-1);
});

function changePresetPosition(increment) {
  let bottom = masterCanvas.height * 0.1;
  let top = masterCanvas.height * 0.9;
  let left = masterCanvas.width * 0.1;
  let right = masterCanvas.width * 0.9;

  option = (option + increment) % 7;
  console.log(option, top, bottom, left, right);
  switch (option) {
    case 0:
      moveCursor(left, top);
      break;
    case 1:
      moveCursor(right, bottom);
      break;
    case 2:
      moveCursor(right, top);
      break;
    case 3:
      moveCursor(left, top);
      break;
    case 4:
      moveCursor(left, bottom);
      break;
    case 5:
      moveCursor(right, bottom);
      break;
    case 6:
      moveCursor(right, top);
      moveCursor(left, bottom);
      break;
  }
  setCursorUniforms();
}
changeMode("auto");
