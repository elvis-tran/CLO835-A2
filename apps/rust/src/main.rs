// CLO835 Assignment 2 — Rust 1.96 starter (standard library only, no crates)
// This is VERSION 0.2. To release VERSION 0.3, change MESSAGE below to:
//   "Hello world from the CLO835 class and <YOUR_STUDENT_ID>!"
// (replace <YOUR_STUDENT_ID> with your own Seneca student ID, e.g. 10112233)
use std::io::{Read, Write};
use std::net::TcpListener;

const VERSION: &str = "0.2";
const MESSAGE: &str = "Hello world from the CLO835 class!";

fn main() {
    let listener = TcpListener::bind("0.0.0.0:8080").expect("bind :8080");
    println!("CLO835 app v{VERSION} listening on :8080");
    for stream in listener.incoming() {
        let mut stream = match stream {
            Ok(s) => s,
            Err(_) => continue,
        };
        let mut buf = [0u8; 1024];
        let _ = stream.read(&mut buf);
        let body = format!("{MESSAGE}\n");
        let response = format!(
            "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\nContent-Length: {}\r\nConnection: close\r\n\r\n{}",
            body.len(),
            body
        );
        let _ = stream.write_all(response.as_bytes());
    }
}
