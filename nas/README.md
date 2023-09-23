
# Goal

Not to be the most hardened Portainer image ever. I'm looking to tighten things up for my use-case. 

As a result, all images are based on official images. This is not a from-scratch image.

Another part of this project is the `example.docker-compose.yml`. Often I demonstrate workable (for me) container hardening. This ideally invovles setting the container disk to read-only, dropping all capabilities, opting to use tailscale instead of exposing any physical ports, and running as a deescalated user (I like to use `nobody` when available.

This may or may not iterate. It's a side-project.

