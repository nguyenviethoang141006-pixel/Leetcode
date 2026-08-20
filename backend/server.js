import "db.js";
import connectDB from "db.js";
import sql from "db.js";
const http = require('node:http');
const port = 3000;

http.get('/', (req, res) => {
  res.send('Hello World!');
});

http.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
// Create the server object
const server = http.createServer((req, res) => {
    // Set the response status and headers
    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/plain');
    
    // Send the final response back to the client
    res.end('Hello from the native Node.js server!\n');
  });
  // Start listening for traffic on port 3000
  server.listen(port, () => {
    console.log(`Server running at http://localhost:${port}/`);
  });
// làm tiếp 