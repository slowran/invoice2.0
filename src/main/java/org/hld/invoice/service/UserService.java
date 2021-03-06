package org.hld.invoice.service;


import org.hld.invoice.common.model.Result;
import org.hld.invoice.dao.UserDao;
import org.hld.invoice.entity.User;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by 李浩然 On 2017/8/10.
 */
public interface UserService {
    Result login(String email, String password, HttpSession session);

    void logout(int userId, HttpSession session);

    Result register(User user, HttpServletRequest request);

    void initAdmin(HttpServletRequest request);

    Result getUser(int userId);

    User getUser(String email);

    Result getUsers(boolean isSuperManager, boolean isManager);

    void modifyUserInformation(User user);

    void modifyUsersInformation(List<User> users);

    Result sendEmail(String address, String email, String action, HttpSession session);

    Result verifyEmailCode(String email, String code);

    Result modifyPassword(String email, String password);

    Result activeUser(String email);

    void outputHeadImage(int id, HttpServletResponse response);

    Result file2Blob(HttpServletRequest request, MultipartFile file);

}
