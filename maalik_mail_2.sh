#!/usr/bin/expect

set trash "[lindex $argv 0]"
set i "[lindex $argv 1]"
set cred "[lindex $argv 2]"
set R "[lindex $argv 3]"
set E "[lindex $argv 4]"

set timeout 10
spawn openssl s_client -connect smtp.gmail.com:465 -crlf -ign_eof 

expect "220" {
send "EHLO localhost\n"

expect "250" {
send "AUTH PLAIN $cred\n"

expect "235" {
send "MAIL FROM: <$E>\n"

expect "250" {
send "RCPT TO: <$R>\n"

expect "250" {
send "DATA\n"

expect "354" {
send "Subject: Test Spam #$i\n\n"
send "Some trash msg - $trash \n"
send "\n.\n"

expect "250" {
send "quit\n"
            }
          }
        }
      }
    }
  }
}
