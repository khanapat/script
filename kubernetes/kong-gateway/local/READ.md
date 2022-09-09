How to deploy kong on localhost

1. ต้องขึ้น database สำหรับ kong และ konga
2. แล้ว migrate kong โดยไปสร้าง database
3. แล้วค่อยขึ้น kong
4. migrate konga สำหรับ UI
5. service ของ kong บน local ต้องใช้เป็น NodePort แทน LoadBalancer

kong port
- 8001 http สำหรับ admin
- 8444 https สำหรับ admin
- 8000 http สำหรับ client
- 8443 https สำหรับ client