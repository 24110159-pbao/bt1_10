package com.webst5.util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class MailUtil_24110159 {

    // ================= GMAIL CONFIG =================
    private static final String GMAIL_USERNAME_24110159 = "ninjabyrt123@gmail.com";
    private static final String GMAIL_APP_PASSWORD_24110159 = "psgo ezqw yhdd dtzh";
    // =================================================

    public static void sendOTP(String receiver, String otp) throws MessagingException {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(
                        GMAIL_USERNAME_24110159,
                        GMAIL_APP_PASSWORD_24110159
                );
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(GMAIL_USERNAME_24110159));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(receiver));
        message.setSubject("Ma OTP dang ky tai khoan");
        message.setText("Ma OTP cua ban la: " + otp + "\nMa co hieu luc trong 5 phut.");

        Transport.send(message);
    }
}
