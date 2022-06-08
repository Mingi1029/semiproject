package test.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import test.dao.CommentDao;
import test.vo.CommentsVo;

@WebServlet("/comm/list")
public class CommentController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int mnum=Integer.parseInt(req.getParameter("mnum"));
		int pageNum=Integer.parseInt(req.getParameter("pageNum"));
		// 
		CommentDao dao=CommentDao.getInstance();
		int startRow = (pageNum-1)*5+1;
		int endRow = startRow+4;
		ArrayList<CommentsVo> list=dao.cList(mnum, startRow , endRow);
		int pageCount=(int)Math.ceil(dao.getCount(mnum)/5.0);
		int startPage=(pageNum-1)/5*5+1;
		int endPage=startPage+4;
		if(endPage>pageCount) {
			endPage=pageCount;
		}
//		System.out.println("list:" + list);
		resp.setContentType("text/plain;charset=utf-8");
		PrintWriter pw=resp.getWriter();
		JSONObject data=new JSONObject();
		JSONArray jarr=new JSONArray();
		for(CommentsVo vo:list){
			JSONObject obj=new JSONObject();
			obj.put("num", vo.getNum());
			obj.put("mnum", vo.getMnum());
			obj.put("id", vo.getId());
			obj.put("comments", vo.getComments());
			jarr.put(obj);
		}
		data.put("list", jarr);
		data.put("pageCount", pageCount);
		data.put("startPage", startPage);
		data.put("endPage", endPage);
		data.put("pageNum", pageNum);
		
		pw.print(data); // 페이징 처리할때는 오브젝트 객체로 넘겨야됨
	}
	
}
 // http://localhost:8081/ajax02_%EB%A6%AC%EB%B7%B0/comm/list?mnum=1&pageNum=2
