package org.example.student_manager.controller;

import org.example.student_manager.model.Student;
import org.example.student_manager.model.User;
import org.example.student_manager.service.StudentDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "StudentServlet", urlPatterns = "/students")
public class StudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private StudentDAO studentDAO;

    public void init() {
        studentDAO = new StudentDAO();
    }

    /**
     * Helper kiểm tra user hiện tại có phải ADMIN không
     */
    private boolean isAdmin(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session == null) return false;
        User user = (User) session.getAttribute("currentUser");
        return user != null && "ADMIN".equals(user.getRole());
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        try {
            switch (action) {
                case "create":
                    insertStudent(req, resp);
                    break;
                case "update":
                    updateStudent(req, resp);
                    break;
                default:
                    resp.sendRedirect(req.getContextPath() + "/students");
                    break;
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }

    private void updateStudent(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        if (!isAdmin(req)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền sửa sinh viên!");
            return;
        }

        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        String birthday = req.getParameter("birthday");
        String address = req.getParameter("address");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        double averageGrade = Double.parseDouble(req.getParameter("averageGrade"));
        String className = req.getParameter("className");

        Student student = new Student(id, name, birthday, address, email, phone, averageGrade, className);

        boolean success = studentDAO.updateStudent(student);
        if (success) {
            req.getSession().setAttribute("message", "✅ Đã sửa sinh viên thành công!");
        } else {
            req.getSession().setAttribute("message", "❌ Sửa sinh viên thất bại!");
        }

        resp.sendRedirect(req.getContextPath() + "/students");
    }

    private void insertStudent(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        if (!isAdmin(req)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền thêm sinh viên!");
            return;
        }

        String name = req.getParameter("name");
        String birthday = req.getParameter("birthday");
        String address = req.getParameter("address");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        double averageGrade = Double.parseDouble(req.getParameter("averageGrade"));
        String className = req.getParameter("className");

        Student newStudent = new Student(name, birthday, address, email, phone, averageGrade, className);

        boolean success = studentDAO.insertStudent(newStudent);
        if (success) {
            req.getSession().setAttribute("message", "✅ Thêm sinh viên mới thành công!");
        } else {
            req.getSession().setAttribute("message", "❌ Thêm sinh viên thất bại!");
        }

        resp.sendRedirect(req.getContextPath() + "/students");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        try {
            switch (action) {
                case "create":
                    showNewForm(req, resp);
                    break;
                case "edit":
                    showEditForm(req, resp);
                    break;
                case "delete":
                    deleteStudent(req, resp);
                    break;
                default:
                    listStudent(req, resp);
                    break;
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }

    private void listStudent(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Student> studentList = studentDAO.selectAllStudents();
        req.setAttribute("studentList", studentList);
        RequestDispatcher dispatcher = req.getRequestDispatcher("student/list.jsp");
        dispatcher.forward(req, resp);
    }

    private void deleteStudent(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        if (!isAdmin(req)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền xoá sinh viên!");
            return;
        }

        int id = Integer.parseInt(req.getParameter("id"));
        boolean success = studentDAO.deleteStudent(id);

        if (success) {
            req.getSession().setAttribute("message", "✅ Đã xoá sinh viên thành công!");
        } else {
            req.getSession().setAttribute("message", "❌ Xoá sinh viên thất bại!");
        }

        resp.sendRedirect(req.getContextPath() + "/students");
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!isAdmin(req)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền sửa sinh viên!");
            return;
        }

        int id = Integer.parseInt(req.getParameter("id"));
        Student existingStudent = studentDAO.selectStudent(id);
        RequestDispatcher dispatcher = req.getRequestDispatcher("student/edit.jsp");
        req.setAttribute("existingStudent", existingStudent);
        dispatcher.forward(req, resp);
    }

    private void showNewForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!isAdmin(req)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền thêm sinh viên!");
            return;
        }

        RequestDispatcher dispatcher = req.getRequestDispatcher("student/create.jsp");
        dispatcher.forward(req, resp);
    }
}
