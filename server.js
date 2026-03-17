const express = require('express');
const cors = require('cors');
const app = express();

app.use(cors());
app.use(express.static('public'));

// Hava Durumu API Proxy
app.get('/api/weather', async (req, res) => {
  try {
    const response = await fetch(
      'https://api.open-meteo.com/v1/forecast?latitude=39.9334&longitude=32.8597&current=temperature_2m,relative_humidity_2m,wind_speed_10m&daily=temperature_2m_max,temperature_2m_min,relative_humidity_2m_max,wind_speed_10m_max&timezone=Europe%2FIstanbul'
    );

    if (!response.ok) {
      throw new Error(`Weather API returned ${response.status}`);
    }

    const data = await response.json();
    res.json(data);
  } catch (error) {
    console.error('Weather API Error:', error);
    res.status(500).json({
      error: error.message,
      fallback: {
        current: {
          temperature_2m: 20,
          relative_humidity_2m: 65,
          wind_speed_10m: 8
        }
      }
    });
  }
});

// Health check endpoint
app.get('/health', (req, res) => {
  res.json({ status: 'OK', timestamp: new Date().toISOString() });
});

// Index sayfasına yönlendir
app.get('/', (req, res) => {
  res.sendFile(__dirname + '/public/index.html');
});

const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
  console.log(`🌱 Kent Bostanları Server running on port ${PORT}`);
  console.log(`📍 Open: http://localhost:${PORT}`);
});
