const express = require('express');
const path = require('path');
const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.static('public'));

app.get('/chelsea', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'chelsea.html'));
});

app.get('/kathryn', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'kathryn-games.html'));
});

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
  console.log(`Visit http://localhost:${PORT}/chelsea for Chelsea's birthday page!`);
  console.log(`Visit http://localhost:${PORT}/kathryn for Kathryn's birthday page!`);
});