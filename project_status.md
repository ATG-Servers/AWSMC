# AWS Minecraft Fabric Server - Project Checkpoint

## Project Status Overview

* **OS:** Debian 13 (Minimal, headless)
* **Instance Type:** m7i-flex.large (2 vCPUs, 8 GiB RAM)
* **Hosting Cost:** ~$73/month if run 24/7 (Planned strategy: Manually Stop the instance when idle to make $100 credits last 7+ months)

## Configured Network Settings

* **Port 22:** SSH enabled (Restricted to your admin IP)
* **Port 25565:** Custom TCP opened to Anywhere (0.0.0.0/0) for player connections

## Recommended Final Tweak Before Launch

* **Storage Adjustment:** Change default volume from 8 GiB to 20 or 30 GiB gp3 (AWS includes up to 30 GB free; handles modded chunk generation and backups)

## Context, Goals, & Priorities

* **What you are doing:** Self-hosting a custom Minecraft Fabric server using a $100 AWS credit balance.
* **Why you are doing it:** To build a performant, lightweight modded multiplayer world to play smoothly with friends without paying for commercial game hosting panels.
* **Your Core Priorities:**
    * **Zero RAM Bottlenecks:** Allocating maximum memory (6.5GB–7GB out of the 8GB available) to support heavy mods.
    * **Strict Budget Efficiency:** Maximizing the lifespan of the $100 credit pool by picking a stripped-down OS (Debian) with zero overhead and turning the machine off when it is not in use.

## Next Step Deliverables

1. Click Launch instance and generate/download the `.pem` key pair file.
2. Provide Antigravity with your local home operating system type (Windows/Mac/Linux).
3. Connect via SSH, install Java 21, and execute the Fabric launch string (`-Xmx7G -Xms7G`).
