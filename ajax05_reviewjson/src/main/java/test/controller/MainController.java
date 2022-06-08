package test.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import test.dao.MovieDao;
import test.vo.MovieVo;

@WebServlet("/main")
public class MainController extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getServletContext().setAttribute("cp", req.getContextPath());
		req.setCharacterEncoding("utf-8");
		MovieDao dao=MovieDao.getInstance();
		ArrayList<MovieVo> list=dao.listAll();
		req.setAttribute("list", list);
		
		req.getRequestDispatcher("/main.jsp").forward(req, resp);
	}

}
