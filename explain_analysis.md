# EXPLAIN Analysis

Truy vấn ban đầu sử dụng `YEAR()` và `MONTH()` trên cột `created_at`, khiến điều kiện lọc trở thành Non-SARGable. Điều này làm MySQL khó khai thác B-Tree Index trên `created_at` và có thể phải thực hiện Full Table Scan. Trong kết quả EXPLAIN, `type` có thể là `ALL`, `key` là `NULL` và `rows` có thể gần với tổng số bản ghi của bảng.

Giải pháp là tạo Composite Index:

```sql
CREATE INDEX idx_type_date
ON Transactions(transaction_type, created_at);
```

Sau đó thay thế `YEAR()` và `MONTH()` bằng điều kiện khoảng:

```sql
created_at >= '2026-06-01 00:00:00'
AND created_at < '2026-07-01 00:00:00'
```

Điều kiện mới có tính SARGable, cho phép MySQL tìm kiếm trực tiếp trên vùng giá trị của Index. Trên dữ liệu đủ lớn và phù hợp, EXPLAIN kỳ vọng `possible_keys` và `key` chứa `idx_type_date`, `type` chuyển sang `range` và số `rows` cần đọc giảm đáng kể.

Kết quả thực tế còn phụ thuộc vào kích thước, phân bố dữ liệu, statistics và quyết định của MySQL Optimizer.
