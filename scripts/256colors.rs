#!/usr/bin/env run-cargo-script

use std::io::{self, Write};

fn main() {
    for i in 0..16 {
        for j in 0..16 {
            let code = i * 16 + j;
            let fullstr = "\u{001b}[48;5;".to_owned()
                + &code.to_string()
                + "m "
                + &format!("{: >3}", code).to_string()
                + " \u{001b}[0m";
            io::stdout().write(&fullstr.as_bytes());
        }
        println!("");
    }
    io::stdout().write("\u{001b}[0m".as_bytes());
}
