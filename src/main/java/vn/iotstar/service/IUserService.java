package vn.iotstar.service;

import vn.iotstar.entity.User;
import java.util.List;

public interface IUserService {
    User registerUser(String username, String password, String role);
    User loginUser(String username, String password);
    User findUserById(Long userId);
    List<User> findAllUsers();
    void updateUser(User user);
    void deleteUser(Long userId);
}