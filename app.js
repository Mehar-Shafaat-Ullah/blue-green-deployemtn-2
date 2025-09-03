const express = require('express');
const app = express();
const PORT = 3000;

// Get environment variable APP_COLOR (default to Blue)
const APP_COLOR = process.env.APP_COLOR || "Blue" ;

app.get('/', (req, res) => {
  res.send(`Hello from ${APP_COLOR} app!`);
});

app.listen(PORT, () => {
  console.log(`App running on port ${PORT} (${APP_COLOR})`);
});

