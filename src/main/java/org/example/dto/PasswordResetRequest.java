package org.example.dto;

import lombok.Data;

@Data
public class PasswordResetRequest {
    private String username;
    private String email;
    private String newPassword;
    private String confirmPassword;
}