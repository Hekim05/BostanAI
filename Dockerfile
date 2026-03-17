FROM node:18-alpine

WORKDIR /app

# package.json oluştur
RUN echo '{\
  "name": "kent-bostanlari",\
  "version": "1.0.0",\
  "scripts": {\
    "start": "node server.js"\
  },\
  "dependencies": {\
    "express": "^4.18.2",\
    "cors": "^2.8.5"\
  }\
}' > package.json

RUN npm install

# Uygulama dosyalarını kopyala
COPY kent-bostanlari-app.jsx ./public/app.jsx
COPY index.html ./public/index.html

# Server oluştur
RUN echo 'const express = require("express");\
const cors = require("cors");\
const https = require("https");\
const app = express();\
\
app.use(cors());\
app.use(express.static("public"));\
\
app.get("/api/weather", async (req, res) => {\
  try {\
    const response = await fetch("https://api.open-meteo.com/v1/forecast?latitude=39.9334&longitude=32.8597&current=temperature_2m,relative_humidity_2m,wind_speed_10m&daily=temperature_2m_max,temperature_2m_min,relative_humidity_2m_max,wind_speed_10m_max&timezone=Europe%2FIstanbul");\
    const data = await response.json();\
    res.json(data);\
  } catch (error) {\
    res.status(500).json({ error: error.message });\
  }\
});\
\
const PORT = process.env.PORT || 8080;\
app.listen(PORT, () => {\
  console.log(`Server running on port ${PORT}`);\
});' > server.js

EXPOSE 8080

CMD ["npm", "start"]
