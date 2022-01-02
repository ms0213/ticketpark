<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-3d.js"></script>
<style>
.box-container .box {
	display: inline-block;
	box-sizing: border-box;
	padding: 20px;
	width: 476px;
	height: 400px;
	border: 1px solid #ccc;
	margin: 10px;
	text-align: center;
}
</style>

<script type="text/javascript">
// 월별 매출
$(function(){
	var url = "${pageContext.request.contextPath}/admin/saleManage/monthSale"
	$.getJSON(url, function(data){
		console.log(data);
		var monthCount=[];
		var monthTotal=[];
		var month=[];
		for(var idx = 0; idx < data.monthSale.length; idx++) {
			var a=[];
			var b=[];
			var c=[];
			
			a.push(data.monthSale[idx].monthCount);
			b.push(data.monthSale[idx].total);
			c.push(data.monthSale[idx].month);
			
			monthCount.push(a);
			monthTotal.push(b);
			month.push(c);
			console.log(c);
		}
		Highcharts.chart('barContainer', {
		    chart: {
		        zoomType: 'xy'
		    },
		    title: {
		        text: '월별 매출 현황'
		    },
		    xAxis: [{
		        categories: month,
		        crosshair: true
		    }],
		    yAxis: [{ // Primary yAxis
		        labels: {
		            format: '{value}원',
		            style: {
		                color: Highcharts.getOptions().colors[1]
		            }
		        },
		        title: {
		            text: '매출액',
		            style: {
		                color: Highcharts.getOptions().colors[1]
		            }
		        }
		    }, { // Secondary yAxis
		        title: {
		            text: '판매량',
		            style: {
		                color: Highcharts.getOptions().colors[0]
		            }
		        },
		        labels: {
		            format: '{value}개',
		            style: {
		                color: Highcharts.getOptions().colors[0]
		            }
		        },
		        opposite: true
		    }],
		    tooltip: {
		        shared: true
		    },
		    legend: {
		        layout: 'vertical',
		        align: 'left',
		        x: 120,
		        verticalAlign: 'top',
		        y: 100,
		        floating: true,
		        backgroundColor:
		            Highcharts.defaultOptions.legend.backgroundColor || // theme
		            'rgba(255,255,255,0.25)'
		    },
		    series: [{
		        name: '판매량',
		        type: 'column',
		        yAxis: 1,
		        data: monthCount,
		        tooltip: {
		            valueSuffix: ' 개'
		        }

		    }, {
		        name: '매출액',
		        type: 'spline',
		        data: monthTotal,
		        tooltip: {
		            valueSuffix: '원'
		        }
		    }]
		});
	});
});

// 공연별 매출
$(function(){
	var url = "${pageContext.request.contextPath}/admin/saleManage/performSale"
		$.getJSON(url, function(data){
			var perfCount=[];
			var total=[];
			var subject=[];
			for(var idx = 0; idx < data.performSale.length; idx++) {
				var a=[];
				var b=[];
				var c=[];
				
				a.push(data.performSale[idx].perfCount);
				b.push(data.performSale[idx].total);
				c.push(data.performSale[idx].subject);
				
				perfCount.push(a);
				total.push(b);
				subject.push(c);
			}
			Highcharts.chart('barContainer2', {
			    chart: {
			        zoomType: 'xy'
			    },
			    title: {
			        text: '공연별 매출 현황'
			    },
			    xAxis: [{
			        categories: subject,
			        crosshair: true
			    }],
			    yAxis: [{ // Primary yAxis
			        labels: {
			            format: '{value}원',
			            style: {
			                color: Highcharts.getOptions().colors[1]
			            }
			        },
			        title: {
			            text: '매출액',
			            style: {
			                color: Highcharts.getOptions().colors[1]
			            }
			        }
			    }, { // Secondary yAxis
			        title: {
			            text: '판매량',
			            style: {
			                color: Highcharts.getOptions().colors[0]
			            }
			        },
			        labels: {
			            format: '{value}개',
			            style: {
			                color: Highcharts.getOptions().colors[0]
			            }
			        },
			        opposite: true
			    }],
			    tooltip: {
			        shared: true
			    },
			    legend: {
			        layout: 'vertical',
			        align: 'left',
			        x: 120,
			        verticalAlign: 'top',
			        y: 100,
			        floating: true,
			        backgroundColor:
			            Highcharts.defaultOptions.legend.backgroundColor || // theme
			            'rgba(255,255,255,0.25)'
			    },
			    series: [{
			        name: '판매량',
			        type: 'column',
			        yAxis: 1,
			        data: perfCount,
			        tooltip: {
			            valueSuffix: ' 개'
			        }

			    }, {
			        name: '매출액',
			        type: 'spline',
			        data: total,
			        tooltip: {
			            valueSuffix: '원'
			        }
			    }]
			});
		});
	});

// 카테고리 선택별 매출
$(function(category){
	var url = "${pageContext.request.contextPath}/admin/saleManage/categorySale"
	var category="concert";
	var query = "category="+category;
	var fn = function(data) {
		console.log(data);
	}
	//ajaxFun(url, "get", query, "json", fn);
});

// 카테고리 전체 매출
$(function(){
	var url = "${pageContext.request.contextPath}/admin/saleManage/categoryAll";
	$.getJSON(url, function(data) {
		var arr=[];
		for(var idx = 0; idx < data.categoryAll.length; idx++) {
			var a=[];
			a.push(data.categoryAll[idx].category);
			a.push(data.categoryAll[idx].total);
			arr.push(a);
		}

		Highcharts.chart('pie3dContainer', {
		    chart: {
		        type: 'pie',
		        options3d: {
		            enabled: true,
		            alpha: 45
		        }
		    },
		    title: {
		        text: '카테고리 전체 매출'
		    },
		    plotOptions: {
		        pie: {
		            innerSize: 100,
		            depth: 45
		        }
		    },
		    
		    series: [{
		    	data:arr
		    }]
		});
	});
});

</script>


	<div class="body-container">
		<div class="body-title">
			<h2> 매출관리  </h2>
		</div>
		
		<div class="box-container" style="margin-top: 15px;">
		    <div id="pie3dContainer" class="box"></div>
		    <div id="barContainer" class="box" style="margin-left: 100px;"></div>
		</div>
	
		<div>
		    <div id="barContainer2" class="box"></div>

		</div>
	</div>
