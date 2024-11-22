mkcd() {
    mkdir -p "$1" && cd "$1"
}

cpp() {
    if [ "$#" -lt 1 ]; then
        echo "Usage: cpp output_file source_file1.cpp source_file2.cpp ..."
        return 1
    fi
    output_file="$1"
    shift
    g "$@" -o "$output_file" && ./"$output_file"
}

