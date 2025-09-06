package org.example.student_manager.controller;

import org.example.student_manager.model.Student;
import org.example.student_manager.model.User;
import org.example.student_manager.service.StudentDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "StudentServlet", urlPatterns = "/students")
public class StudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private StudentDAO studentDAO;

    public void init() {
        studentDAO = new StudentDAO();
    }

    private boolean isAdmin(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session == null) return false;
        User user = (User) session.getAttribute("currentUser");
        return user != null && "ADMIN".equals(user.getRole());
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "";
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

        req.getSession().setAttribute("message", success ? "✅ Thêm sinh viên mới thành công!" : "❌ Thêm sinh viên thất bại!");
        resp.sendRedirect(req.getContextPath() + "/students");
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

        req.getSession().setAttribute("message", success ? "✅ Đã sửa sinh viên thành công!" : "❌ Sửa sinh viên thất bại!");
        resp.sendRedirect(req.getContextPath() + "/students");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "";
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

    private void listStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int page = 1;
        int recordsPerPage = 9;

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        String searchName = request.getParameter("searchName");
        String className = request.getParameter("className");

        List<Student> studentList = new ArrayList<>();
        int totalRecords = 0;

        try {
            if (searchName != null && !searchName.trim().isEmpty()) {
                // 🔎 Tìm theo tên (có phân trang)
                studentList = studentDAO.selectStudentsByNamePage(searchName,
                        (page - 1) * recordsPerPage, recordsPerPage);
                totalRecords = studentDAO.countStudentsByName(searchName);

            } else if (className != null && !className.trim().isEmpty()) {
                // 🏫 Lọc theo lớp (có phân trang)
                studentList = studentDAO.findByClassNamePage(className,
                        (page - 1) * recordsPerPage, recordsPerPage);
                totalRecords = studentDAO.countStudentsByClassName(className);

            } else {
                // 📋 Lấy tất cả sinh viên (có phân trang)
                studentList = studentDAO.selectStudentsPage((page - 1) * recordsPerPage, recordsPerPage);
                totalRecords = studentDAO.countStudents();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

        request.setAttribute("studentList", studentList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("student/list.jsp").forward(request, response);
    }


    private void deleteStudent(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        if (!isAdmin(req)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền xoá sinh viên!");
            return;
        }

        int id = Integer.parseInt(req.getParameter("id"));
        boolean success = studentDAO.deleteStudent(id);
        req.getSession().setAttribute("message", success ? "✅ Đã xoá sinh viên thành công!" : "❌ Xoá sinh viên thất bại!");
        resp.sendRedirect(req.getContextPath() + "/students");
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!isAdmin(req)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền sửa sinh viên!");
            return;
        }

        int id = Integer.parseInt(req.getParameter("id"));
        Student existingStudent = studentDAO.selectStudent(id);
        req.setAttribute("student", existingStudent); // 🔹 đặt đúng tên để JSP nhận dữ liệu
        RequestDispatcher dispatcher = req.getRequestDispatcher("student/edit.jsp");
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
