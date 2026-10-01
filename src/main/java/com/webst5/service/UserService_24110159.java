package com.webst5.service;

import com.webst5.dao.UserDAO_24110159;
import com.webst5.dao.UserDAO_24110159;
import com.webst5.entity.User_24110159;

public class UserService_24110159 {
    private final UserDAO_24110159 dao = new UserDAO_24110159();

    public User_24110159 login(String username, String password) {
        User_24110159 user = dao.findByUsername(username);
        if (user != null && password.equals(user.getPassword()) &&
                (user.getStatus() == null || user.getStatus() == 1)) return user;
        return null;
    }
    public boolean usernameExists(String username) { return dao.findByUsername(username) != null; }
    public boolean emailExists(String email) { return dao.findByEmail(email) != null; }
    public User_24110159 register(User_24110159 user) { return dao.save(user); }
}
