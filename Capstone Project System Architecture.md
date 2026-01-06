
```mermaid
graph TB subgraph Physical["PHYSICAL ENVIRONMENT"] Webcam["Webcam<br/>Camera & Mic<br/>---<br/>Signal: Raw Video/Audio<br/>Protocol: USB"] PIR["PIR Motion Sensor<br/>OPTIONAL<br/>---<br/>Signal: Digital High/Low<br/>Protocol: GPIO"] TempHum["Temp/Humidity<br/>OPTIONAL<br/>---<br/>Signal: Digital Data<br/>Protocol: I2C"] end

subgraph RaspberryPi["ON-DEVICE PROCESSING (Raspberry Pi 5)"] subgraph DataAcq["Data Acquisition Module (CPU)"] PreProc["Pre-Processing<br/>• Resize frames<br/>• Normalize data<br/>• Format conversion"] end

subgraph AIEngine["AI Inference Engine"] CoralTPU["Google Coral TPU<br/>Vision Model<br/>---<br/>Input: Pre-processed images<br/>Output: JSON objects<br/>{object: 'child',<br/>activity: 'crawling'}"] AudioModel["Audio Model (CPU)<br/>---<br/>Detects: cry, loud_crash<br/>Output: Event type + confidence"] end

Logic["Main Application<br/>& Logic Module (CPU)<br/>---<br/>Rules Engine:<br/>IF crawling + near_stairs<br/>THEN trigger_alert"]

subgraph Network["Networking Services (CPU)"] StreamServer["Live Stream Server<br/>Flask/WebRTC<br/>---<br/>Port: 8080 (HTTP)"] NotifClient["Notification Client<br/>---<br/>Sends alerts via HTTPS API"] end end

subgraph External["EXTERNAL SERVICES & OUTPUT"] Router["Home Wi-Fi Router<br/>---<br/>Protocol: 802.11ac<br/>Manages local + internet traffic"]

Cloud["Cloud Notification Service<br/>Apple Push Notifications<br/>---<br/>Protocol: HTTPS<br/>Relay: Push notifications"]

Mobile["Parent's Mobile App<br/>---<br/>Functions:<br/>1. Receives push alerts<br/>2. Views live stream<br/>3. Sends configuration"] end

%% Data Flow Connections Webcam -->|USB: Video/Audio Stream| PreProc PIR -->|GPIO: Wake Signal| PreProc TempHum -->|I2C: Sensor Readings| PreProc

PreProc -->|Processed Images| CoralTPU PreProc -->|Audio Stream| AudioModel

CoralTPU -->|JSON: Inference Results| Logic AudioModel -->|Event Data| Logic

Logic -->|Video Feed| StreamServer Logic -->|Alert Trigger| NotifClient

StreamServer -.->|Local WiFi<br/>HTTP/WebRTC| Router NotifClient -->|HTTPS Request| Router

Router -->|Internet| Cloud Router -.->|Local Network<br/>Stream Access| Mobile

Cloud -->|Push Notification<br/>Over Internet| Mobile Mobile -.->|Config Data<br/>HTTP Request| Router Router -.->|Local WiFi| Logic

%% Styling classDef sensor fill:`#e1f5ff`,stroke:`#0288d1`,stroke-width:2px classDef processing fill:`#fff3e0`,stroke:`#f57c00`,stroke-width:2px classDef ai fill:`#f3e5f5`,stroke:`#7b1fa2`,stroke-width:3px classDef network fill:`#e8f5e9`,stroke:`#388e3c`,stroke-width:2px classDef external fill:`#fce4ec`,stroke:`#c2185b`,stroke-width:2px
```
