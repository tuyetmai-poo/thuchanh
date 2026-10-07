# AI Prompt Log

## Prompt 1 - Non-SARGable

Trong MySQL, nếu tôi tạo Index cho một cột ngày tháng nhưng trong mệnh đề WHERE lại sử dụng `YEAR(created_at)` và `MONTH(created_at)`, tại sao MySQL khó sử dụng Index và có thể phải thực hiện Full Table Scan?

## Prompt 2 - SARGable

SARGable trong SQL là gì? Tại sao việc sử dụng điều kiện `created_at >= ... AND created_at < ...` lại giúp B-Tree Index hoạt động hiệu quả hơn so với việc sử dụng `YEAR(created_at)`?

## Prompt 3 - Composite Index

Khi thiết kế Composite Index trên `(transaction_type, created_at)`, thứ tự các cột có ý nghĩa như thế nào? Vì sao điều kiện equality trên `transaction_type` kết hợp với range trên `created_at` phù hợp với Index này?

## Prompt 4 - EXPLAIN

Trong MySQL EXPLAIN, các giá trị `ALL`, `range`, `ref`, `const` trong cột `type` có ý nghĩa gì? Giá trị nào thường cho thấy Full Table Scan?

## Prompt 5 - possible_keys và key

Trong kết quả EXPLAIN của MySQL, `possible_keys` và `key` khác nhau như thế nào? Nếu `possible_keys` có tên Index nhưng `key` là NULL thì điều đó có nghĩa gì?

## Prompt 6 - Extra

Trong MySQL EXPLAIN, `Using index condition` khác gì `Using index`? `Using index` có liên quan gì đến Covering Index?

## Prompt 7 - Index và Write Performance

Tại sao việc tạo quá nhiều Index có thể làm giảm hiệu năng INSERT, UPDATE và DELETE?

## Prompt 8 - Full Table Scan

Trong trường hợp nào Full Table Scan có thể nhanh hơn Index Scan, ví dụ khi truy vấn cần lấy phần lớn dữ liệu của một bảng nhỏ?

## Prompt 9 - SQL Logical Processing Order

Thứ tự xử lý logic của các mệnh đề SQL như FROM, WHERE, GROUP BY, HAVING và SELECT là gì? Tại sao WHERE được xử lý trước SELECT về mặt logic?
