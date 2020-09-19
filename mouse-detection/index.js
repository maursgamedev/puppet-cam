const dgram = require('dgram');
const message = Buffer.from('Some bytes');
const client = dgram.createSocket('udp4');

client.connect(41234, 'localhost', (err) => {
  client.send(message, (err) => {
    client.close();
  });
});