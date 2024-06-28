
const cors = require('cors');
const express = require('express');
const app = express();
const port = 3000; 
app.use(cors());
// Import module 'fs'
const fs = require('fs');

// Sử dụng middleware để phục vụ tài liệu Swagger từ tệp YAML
const swaggerUi = require('swagger-ui-express');
const YAML = require('yaml');

// Đọc nội dung của tệp YAML và phân tích thành đối tượng JSON
const file = fs.readFileSync('./appdocsach-swagger.yaml', 'utf8');
const swaggerDocument = YAML.parse(file);

// Sử dụng swagger-ui-express để hiển thị tài liệu Swagger
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));

// Khởi động server
app.listen(port, () => {
  console.log(`Server đang chạy trên cổng ${port}`);
  console.log(`Truy cập Swagger tại http://localhost:${port}/api-docs`);
});
