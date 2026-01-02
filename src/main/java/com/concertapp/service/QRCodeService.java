package com.concertapp.service;

import org.springframework.stereotype.Service;

@Service
public class QRCodeService {
    
    public String generateQRCode(String text, int width, int height) {
        // Dummy QR code for now
        return "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg==";
    }
}