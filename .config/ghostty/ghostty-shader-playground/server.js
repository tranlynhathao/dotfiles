const http = require("http");
const fs = require("fs");
const path = require("path");
const WebSocket = require("ws");

const PORT = 3000;
const ROOT_DIR = __dirname;
const SHADERS_DIR = path.join(ROOT_DIR, "shaders");
const PUBLIC_FILES = ["index.html", "main.js", "ghostty_wrapper.glsl"];

const MIME_TYPES = {
  ".html": "text/html",
  ".js": "application/javascript",
  ".glsl": "text/plain",
  ".json": "application/json",
};

const server = http.createServer(handleRequest);

function handleRequest(req, res) {
  const urlPath = req.url === "/" ? "/index.html" : req.url;
  const filePath = path.join(ROOT_DIR, urlPath);

  if (req.url === "/shaders-list") {
    return listShaders(res);
  }

  if (
    req.url.startsWith("/shaders/") ||
    PUBLIC_FILES.includes(urlPath.slice(1))
  ) {
    return serveFile(
      filePath,
      MIME_TYPES[path.extname(filePath)] || "application/octet-stream",
      res,
    );
  }

  return notFound(res);
}

function serveFile(filePath, mimeType, res) {
  fs.readFile(filePath, (err, content) => {
    if (err) {
      console.error(`Error reading file: ${filePath}`, err);
      res.writeHead(500, { "Content-Type": "text/plain" });
      return res.end("Server error");
    }
    res.writeHead(200, { "Content-Type": mimeType });
    res.end(content);
  });
}

function listShaders(res) {
  fs.readdir(SHADERS_DIR, (err, files) => {
    if (err) {
      console.error("Failed to read shaders directory", err);
      res.writeHead(500, { "Content-Type": "application/json" });
      return res.end(
        JSON.stringify({ error: "Unable to read shaders directory" }),
      );
    }

    const shaderFiles = files.filter((f) => f.endsWith(".glsl"));
    res.writeHead(200, { "Content-Type": "application/json" });
    res.end(JSON.stringify(shaderFiles));
  });
}

function notFound(res) {
  res.writeHead(404, { "Content-Type": "text/plain" });
  res.end("Not found");
}

const wss = new WebSocket.Server({ server });

function broadcastReload() {
  wss.clients.forEach((client) => {
    if (client.readyState === WebSocket.OPEN) {
      client.send("reload");
    }
  });
}

function watchForChanges() {
  const watchPaths = [
    ...PUBLIC_FILES.map((f) => path.join(ROOT_DIR, f)),
    SHADERS_DIR,
  ];

  for (const p of watchPaths) {
    try {
      const stats = fs.lstatSync(p);
      if (stats.isDirectory()) {
        fs.watch(p, (event, filename) => {
          if (filename && filename.endsWith(".glsl")) {
            console.log(`Shader changed: ${filename}`);
            broadcastReload();
          }
        });
      } else {
        fs.watchFile(p, () => {
          console.log(`File changed: ${path.basename(p)}`);
          broadcastReload();
        });
      }
    } catch (err) {
      console.error(`Failed to watch: ${p}`, err);
    }
  }
}

watchForChanges();

server.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
