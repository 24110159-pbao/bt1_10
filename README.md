# WEBST5 - 24110159

## Công nghệ
- Java 21
- Maven WAR
- Jakarta Servlet 6
- Jakarta Persistence 3.1 / Hibernate
- JSP + JSTL
- MySQL
- Gmail SMTP OTP

## Database
Tên database: `webst5`

1. Tạo database bằng `database/webst5.sql`.
2. Nếu MySQL có password, sửa `src/main/resources/META-INF/persistence.xml`.
3. Tài khoản mẫu được tự động tạo khi ứng dụng chạy:
   - admin / 123456
   - user / 123456

## Gmail OTP
Mở:
`src/main/java/com/webst5/util/MailUtil_24110159.java`

Sửa:
`GMAIL_USERNAME_24110159`
`GMAIL_APP_PASSWORD_24110159`

Mật khẩu phải là Google App Password 16 ký tự, không phải mật khẩu Gmail thông thường.

## Chạy
- Dùng Tomcat 10.1+
- Maven: `mvn clean package`
- Deploy file `target/webst5-24110159.war` vào Tomcat.

## Cấu trúc Java đơn giản

```text
com/webst5/
├── entity/
├── dao/
├── service/
├── controller/
├── filter/
├── listener/
└── util/
```

Không dùng `dao/impl` và `service/impl`.
Luồng xử lý:

Controller -> Service -> DAO -> Entity -> MySQL
```
