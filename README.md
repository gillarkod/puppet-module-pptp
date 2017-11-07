# pptp

## Overview

Manage pptp and connections.

Tested on CentOS 7.

## Example hiera config

```pptp::connections:
  - name: 'vpn'
    ip: '10.0.0.2'
    route: '172.16.0.0/24'
    username: 'myusername'
    password: 'mypassword'
    running: true
    enable: true
```
