<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.comm{width: 400px;height: 100px;border:1px solid #aaa;margin-bottom: 5px;}
</style>
<script type="text/javascript">
	window.onload=function(){
		commList(1); // 메소드 호출할때마다 보여질 페이지 == 1
	}
	// 댓글 목록 보여주는
	function commList(pageNum){
		let xhr=new XMLHttpRequest();
		xhr=new XMLHttpRequest();
		xhr.onreadystatechange=function(){
			if(xhr.readyState==4 && xhr.status==200){
				var result=xhr.responseText;
				let commList=document.getElementById("commList");
				//기존 댓글 지우기
				let child=commList.childNodes; // 자식노드 얻어오기
				for(let i=child.length-1;i>=0;i--){
					let c=child.item(i);
					commList.removeChild(c);
				}
				let data=JSON.parse(result);
				let comm=data.list;
				for(var i=0;i<comm.length;i++){
					var id=comm[i].id;
					var comments=comm[i].comments;
					var num=comm[i].num;
					var mnum=comm[i].mnum;
					var div=document.createElement("div");
					div.innerHTML="아이디:" + id + "<br>" +
								  "내용:" + comments + "<br>" +
								  "<a href='javascript:delComm("+ num +")'>삭제</a>";
					div.className="comm";
					commList.appendChild(div);
				}
				let startPage=data.startPage;
				let endPage=data.endPage;
				let pageCount=data.pageCount;
				let pageHTML="";
				if(startPage>5){
					pageHTML += "<a href='javascript:commList("+(startPage-1)+")'>이전</a>";
				}
				for(let i=startPage;i<=endPage;i++){
					if(i==pageNum){
						pageHTML += "<a href='javascript:commList("+ i +")'><span style='color:blue'>["+ i +"]</span></a>";
					}else{
						pageHTML += "<a href='javascript:commList("+ i +")'><span style='color:gray'>["+ i +"]</span></a>";
					}
				}
				if(endPage<pageCount){
					pageHTML += "<a href='javascript:commList("+ (endPage+1) + ")'>다음</a>";
				}
				var page=document.getElementById("page");
				page.innerHTML=pageHTML;
			}
		};
		xhr.open('get','${pageContext.request.contextPath}/comm/list?mnum=${vo.mnum}&pageNum='+pageNum,true);
		xhr.send();
	}
	
	
	function delComm(num){
		let xhr=new XMLHttpRequest();
		xhr.onreadystatechange=function(){
			if(xhr.readyState==4 && xhr.status==200){
				let data=xhr.responseText;
				let json=JSON.parse(data);
				if(json.code=='success'){
					commList(1);
				}else{
					alert('삭제실패');
				}
			}
		};
		xhr.open('get','${pageContext.request.contextPath}/comm/delete?num='+num,true);
		xhr.send();
	}
	function addComm(){		
		let xhr=new XMLHttpRequest();
		xhr.onreadystatechange=function(){
			if(xhr.readyState==4 && xhr.status==200){
				let data=xhr.responseText;
				let json=JSON.parse(data);
				
				if(json.code=='success'){
					//alert("리뷰등록성공");
					commList(1);
				}else{
					alert("리뷰등록실패");
				}
			}
		};
		let id=document.getElementById("id").value;
		let comments=document.getElementById("comments").value;
		let param="id=" + id + "&comments=" + comments + "&mnum=${vo.mnum}";
		xhr.open('post','${pageContext.request.contextPath}/comm/insert',true);
		xhr.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
		xhr.send(param);
	}


</script>
</head>
<body>
	<div id="detail" style="background-color: lightgray; width: 400px; height: 200px;">
		<h1>${vo.title }</h1><br>
		<p>
		내용: ${vo.content }<br>
		감독: ${vo.director }<br>
		</p>
	</div>
<div>
	<div id="commList"></div>
	<div id="page"></div> <!-- 페이징처리 div -->
	<div id="commAdd">
		아이디<br>
		<input type="text" id="id"><br>
		영화평<br>
		<textarea rows="3" cols="50" id="comments"></textarea><br>
		<input type="button" value="등록" onclick="addComm()">
	</div>
</div>
</body>
</html>