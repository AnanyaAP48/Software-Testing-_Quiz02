*** Settings ***
Library    SeleniumLibrary
Library    Dialogs    # เรียกใช้ Library สำหรับสร้างหน้าต่างป๊อปอัพ
 
*** Variables ***
${URL}     https://chiangmuan.igovapp.com
${BROWSER}    chrome
 
*** Test Cases ***
Login And Register Test
    # 1. เปิดเว็บขึ้นมา
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
   
    # 2. หยุดรอให้คนกด Login
    # Robot จะเด้งหน้าต่างเล็กๆ ขึ้นมาเตือน ค้างไว้
    # ให้คุณไปกด "เข้าสู่ระบบด้วย LINE" และสแกน QR บนเว็บให้เสร็จจนหน้าเว็บเปลี่ยน
    Pause Execution    กรุณาล็อกอิน LINE ให้เสร็จ จนเข้าหน้าหลักได้ แล้วค่อยกด OK ปุ่มนี้
 
    # 3. ตรวจสอบว่าเข้าได้จริงไหม (Validation)
    # หลังจากกด OK ด้านบน Robot จะเช็คว่ามี URL เปลี่ยนไปจากหน้า Login ไหม
    # หรือเช็คว่าเจอคำว่า "ออกจากระบบ" หรือ "ข้อมูลส่วนตัว" หรือไม่
    ${current_url}=    Get Location
    Log To Console     Current URL is: ${current_url}
   
    # ถ้า Login สำเร็จ URL ไม่ควรเป็นหน้า Login เดิม (หรือควรมีคำว่า home/dashboard)
    # หรือลองเช็คคำที่น่าจะเจอหลัง Login เช่น "ยินดีต้อนรับ" หรือ "เมนูหลัก"
    Page Should Contain    หน้าหลัก    # <-- ลองเปลี่ยนคำนี้เป็นคำที่เจอจริงๆ บนหน้าเว็บหลัง Login
   
    Log To Console     Login Success!
   
    # 4. จบการทำงาน
    Close Browser