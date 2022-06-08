package test.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import test.dao.MovieDao;
import test.vo.MovieVo;

@WebServlet("/detail")
public class DetailController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int mnum=Integer.parseInt(req.getParameter("mnum"));
		
		MovieDao dao=MovieDao.getInstance();
		MovieVo vo=dao.detail(mnum);
		
		req.setAttribute("vo", vo);
		req.getRequestDispatcher("/detail.jsp").forward(req, resp);
	}
}
