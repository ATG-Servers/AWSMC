# AWS Minecraft Fabric Server - Project Checkpoint

## Project Status Overview

* **OS:** Debian 13 (Minimal, headless)
* **Instance Type:** m7i-flex.large (2 vCPUs, 8 GiB RAM)
* **Hosting Cost:** ~$73/month if run 24/7 (Planned strategy: Manually Stop the instance when idle to make $100 credits last 7+ months)

## Configured Network Settings

* **Port 22:** SSH enabled (Restricted to your admin IP)
* **Port 25565:** Custom TCP opened to Anywhere (0.0.0.0/0) for player connections

## Context, Goals, & Priorities

* **What you are doing:** Self-hosting a custom Minecraft Fabric server using a $100 AWS credit balance.
* **Why you are doing it:** To build a performant, lightweight modded multiplayer world to play smoothly with friends without paying for commercial game hosting panels.
* **Your Core Priorities:**
    * **Zero RAM Bottlenecks:** Allocating maximum memory (6.5GB–7GB out of the 8GB available) to support heavy mods.
    * **Strict Budget Efficiency:** Maximizing the lifespan of the $100 credit pool by picking a stripped-down OS (Debian) with zero overhead and turning the machine off when it is not in use.

## Completed Milestones

1. **Instance Launch & Access:** 
   * Instance successfully launched.
   * `.pem` key pair downloaded locally.
   * File permissions on `MinecraftServer.pem` secured via `icacls` to allow SSH connection from Windows.
2. **Version Control Integration:**
   * Local Git repository initialized.
   * Repository successfully linked and pushed to a specific secondary GitHub account using HTTPS (`ATG-Servers/AWSMC`).
3. **Server Provisioning:**
   * Connected via SSH to the Debian instance as `admin`.
   * OS packages updated (preserving AWS's secure `sshd_config`).
   * **Java 21** (`openjdk-21-jre-headless`) installed.
4. **Minecraft Fabric Setup:**
   * Base directory `~/fabric-server` created.
   * Downloaded `fabric-installer-1.0.1.jar`.
   * Installed **Minecraft version 26.1.2** with Fabric server files.
   * EULA automatically accepted.
5. **Server Management Scripts:**
   * `start.sh`: Configured with aggressive memory allocation (`-Xmx7G -Xms7G`).
   * `update-server.sh`: A custom script designed to automatically download and upgrade the Minecraft Fabric version via a CLI argument (e.g., `./update-server.sh 26.2.0`).

## Next Step Deliverables

1. Validate the server starts successfully using `./start.sh`.
2. Configure **tmux** or **screen** so the Minecraft server continues running continuously in the background after the SSH connection is closed.
3. Review and test connecting to the server via the AWS Public IP.
