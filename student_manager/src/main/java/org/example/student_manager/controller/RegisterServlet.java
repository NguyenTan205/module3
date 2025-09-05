package org.example.student_manager.controller;

import org.example.student_manager.model.User;
import org.example.student_manager.service.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "RegisterServlet", urlPatterns = "/register")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Hiển thị form đăng ký
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Lấy dữ liệu từ form
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        // Kiểm tra username đã tồn tại chưa
        if (userDAO.existsByUsername(username)) {
            req.setAttribute("error", "⚠️ Tên đăng nhập đã tồn tại!");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        } else {
            // Tạo user mới với role mặc định là "user"
            User newUser = new User();
            newUser.setUsername(username);
            newUser.setPassword(password);
            newUser.setRole("user"); // 👈 luôn là user

            // Lưu vào DB
            userDAO.insertUser(newUser);

            // Lưu thông báo vào session
            HttpSession session = req.getSession();
            session.setAttribute("message", "✅ Đăng ký thành công, mời bạn đăng nhập!");

            // Chuyển hướng sang login.jsp
            resp.sendRedirect(req.getContextPath() + "/login");
        }
    }
}
