<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title></title>
	<meta charset="utf-8">
	<style>
		select {
			height: 26px;
			margin: 3px 6px;
		}
		table.schedule {
			margin: 3px 6px;
			border-spacing: 0px;
			border-top: 1px solid #555555;
			border-left: 1px solid #555555;
		}
		table.schedule > thead > tr {
			height: 32px;
			background: #e6edef;
		}
		table.schedule > thead > tr > th {
			padding: 3px 6px;
			border-bottom: 1px solid #555555;
			border-right: 1px solid #555555;
			vertical-align: top;
		}
		table.schedule > tbody > tr {
			height: 107px;
		}
		table.schedule > tbody > tr > td {
			padding: 3px 6px;
			border-bottom: 1px solid #555555;
			border-right: 1px solid #555555;
			vertical-align: top;
		}
	</style>
	<script src="http://code.jquery.com/jquery.min.js"></script>
</head>

<body>
	<div>
		<select class="year">
			<c:forEach begin="${params.year-2}" end="${params.year+2}" var="i">
				<c:set var="j" value="${params.year+2-i+params.year-2}"/>
				<option value="${j}" ${params.year == j ? 'selected':''}>${j}</option>
			</c:forEach>
		</select>
		
		<select class="month">
			<c:forEach begin="1" end="12" var="i">
				<option value="${i}" ${params.month == i ? 'selected':''}>${i}</option>
			</c:forEach>
		</select>
	</div>

	<table class="schedule">
		<thead>
			<tr>
				<th style="width: 128px;">Sun</th>
				<th style="width: 128px;">Mon</th>
				<th style="width: 128px;">Tue</th>
				<th style="width: 128px;">Wed</th>
				<th style="width: 128px;">Thu</th>
				<th style="width: 128px;">Fri</th>
				<th style="width: 128px;">Sat</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="i" begin="1" end="6">
			<tr>
				<c:forEach var="j" begin="1" end="7">
					<c:set var="num" value="${i}${j}"/>
					<c:set var="memo_num" value="memo${num}"/>
					<td>
						<div class="day-num">${params.weeks[num]}</div>
						<div class="day-memo">${memo[memo_num]}</div>
					</td>	
				</c:forEach>
			</tr>
		</c:forEach>
		</tbody>
	</table>

	<script>
		$(function() {
			$('.year').change(function(){
				location.href = "/schedule/main.do?year=" + $('.year').val() + "&month=" + $('.month').val();
			});
			$('.month').change(function(){
				location.href = "/schedule/main.do?year=" + $('.year').val() + "&month=" + $('.month').val();
			});
		});
	</script>

</body>
</html>
