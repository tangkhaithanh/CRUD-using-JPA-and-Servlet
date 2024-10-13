package vn.iotstar.dao;

import vn.iotstar.entity.User;
import java.util.List;

public interface IUserDao {
    void saveUser(User user);
    User findById(Long userId);
    User findByUsername(String username);
    List<User> findAllUsers();
    void updateUser(User user);
    void deleteUser(Long userId);
}