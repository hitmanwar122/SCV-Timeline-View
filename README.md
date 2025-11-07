# 🕓 SCV Timeline View — Customer Journey for Service Cloud Voice

This repository contains a **Salesforce Lightning Web Component (LWC)** and an **Apex controller** that together display a visually rich, connected timeline of a customer’s recent **VoiceCall** interactions inside Salesforce **Service Cloud Voice (SCV)**.

It is designed for contact-center supervisors, agents, and admins who want an **at-a-glance “customer journey”** showing inbound/outbound calls, status, timestamps, and duration — all rendered with a clean SLDS timeline aesthetic.

---

## ✨ Features

### 🔹 1. Dynamic VoiceCall Timeline
- Displays up to **10 most recent Voice Calls** associated with the same customer phone number.  
- Fetches both **Inbound** and **Outbound** directions, ordered by most recent first.  
- Each entry shows:
  - **Call Type** (Inbound / Outbound)
  - **Disposition / Status**
  - **Start Date & Time**
  - **Call Duration**

### 🔹 2. Visual Journey Layout
- Modern **timeline visualization** using SLDS (`lightning-card` + custom CSS).  
- **Color-coded badges**:
  - 🟢 Inbound → green
  - 🟠 Outbound → orange  
- A thin **vertical connector line** visually links all interactions for an intuitive customer-journey feel.

### 🔹 3. Inline Record Linking
- Each timeline entry includes a **direct hyperlink** to the corresponding `VoiceCall` record — so supervisors can drill down immediately.

### 🔹 4. Auto-Contextual Data Fetch
- Uses an Apex method (`CustomerJourneyController.getCustomerJourney`) with the current record’s ID.  
- Smartly determines the associated phone number (either `CallerPhone` or `RecipientPhone`) to retrieve all matching calls.

### 🔹 5. Lightweight & Cacheable
- Uses `@AuraEnabled(cacheable=true)` for responsive client-side performance.  
- Minimal Apex logic and no external dependencies — deploy and use in minutes.

---

## 🧩 Technical Overview

**Component:** `customerJourneyTimeline`  
**Controller:** `CustomerJourneyController.cls`

### Folder Structure
```
force-app/main/default/
├── classes/
│   ├── CustomerJourneyController.cls
│   └── CustomerJourneyController.cls-meta.xml
└── lwc/
    └── customerJourneyTimeline/
        ├── customerJourneyTimeline.css
        ├── customerJourneyTimeline.html
        ├── customerJourneyTimeline.js
        └── customerJourneyTimeline.js-meta.xml
```

---

## ⚙️ Installation & Deployment

### 1️⃣ Deploy to Org
Using Salesforce CLI (SFDX):
```bash
sfdx auth:web:login -a MySandbox
sfdx force:source:deploy -p force-app/main/default -u MySandbox
```

### 2️⃣ Add Component to Page
1. Navigate to any **VoiceCall** record in Salesforce.
2. Click **⚙️ → Edit Page** (Lightning App Builder).
3. Drag **Customer Journey Timeline** onto the layout.
4. Save and activate.

### 3️⃣ Test It
- Open a `VoiceCall` record that has multiple recent calls for the same phone number.
- You’ll see a timeline like this:
  ```
  • Outbound – 2 Nov 2025  |  Disposition: Answered  |  Duration: 180s
  • Inbound  – 1 Nov 2025  |  Disposition: Missed    |  Duration: 0s
  ```
- Click any entry to jump directly to that VoiceCall record.

---

## 🧱 Implementation Notes

- Works natively with **Service Cloud Voice** and any org where `VoiceCall` data is available.
- You can customize:
  - The limit (currently 10 records).
  - Badge colors in `customerJourneyTimeline.css`.
  - Additional fields from the `VoiceCall` object (queue name, owner, etc.).
- The design intentionally **hides SLDS rails** and **draws a clean custom connector** for better aesthetics.

---

## 🧰 Future Enhancements (Ideas)

| Enhancement | Description |
|--------------|-------------|
| 🎙 Einstein Work Summaries | Integrate AI-generated summaries of call transcripts under each timeline item. |
| 🔁 Lazy Loading | Fetch additional call history when scrolling. |
| 🧭 Cross-Channel History | Extend to display SMS, Chat, or Case events for unified journey. |
| 📊 Metrics | Add average handling time or sentiment trend visualization. |
| 🔒 Custom Permissions | Control visibility via a Permission Set for supervisors only. |

---

## 👨‍💻 Author

**Hitesh Manwar**  
Principal Product Manager – Twilio Flex / Salesforce Voice Integrations  
📍 Bengaluru, India  
💬 [GitHub: @hitmanwar122](https://github.com/hitmanwar122)

---

## 🪶 License

MIT License © 2025 Hitesh Manwar

Use freely within Salesforce orgs. Attribution appreciated.

---
