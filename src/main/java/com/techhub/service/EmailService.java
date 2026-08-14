package com.techhub.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    private static final Logger log = LoggerFactory.getLogger(EmailService.class);

    private final JavaMailSender mailSender;

    @Value("${spring.mail.username:prathameshvhae39@gmail.com}")
    private String fromEmail;

    public EmailService(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    public void sendEmail(String to, String subject, String body) {
        try {
            log.info("Sending email notification from: {} to recipient: {}", fromEmail, to);
            System.out.println(">>> [EmailService] Dispatching email to: " + to);
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(fromEmail);
            message.setTo(to);
            message.setSubject(subject);
            message.setText(body);
            mailSender.send(message);
            log.info("Email successfully sent to: {}", to);
            System.out.println(">>> [EmailService] EMAIL SENT SUCCESSFULLY to: " + to);
        } catch (Exception e) {
            log.error("SMTP Email Dispatch Error for recipient {}: ", to, e);
            System.err.println(">>> [EmailService] ERROR SENDING EMAIL: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
