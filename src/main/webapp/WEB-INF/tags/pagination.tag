<%@ tag pageEncoding="UTF-8"%>
<%@ attribute name="page" type="com.github.miemiedev.mybatis.paginator.domain.PageList"
	required="true"%>
<%@ attribute name="paginationSize" type="java.lang.Integer"
	required="true"%>
<%@ attribute name="pageUrl" type="java.lang.String" required="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%
	int current = page.getPaginator().getPage();
	int begin = Math.max(1, current - paginationSize / 2);
	if (!page.getPaginator().isHasNextPage()) {
		if (page.getPaginator().getTotalPages() > 4) {
			begin = current - 4;

		} else {
			begin = 1;
		}
	}
	int end = Math.min(begin + (paginationSize - 1),
			page.getPaginator().getTotalPages());

	request.setAttribute("current", current);
	request.setAttribute("begin", begin);
	request.setAttribute("end", end);
	request.setAttribute("pa", current);
	request.setAttribute("paginationSize", paginationSize);
	
%>
<c:if test="${pageUrl != null && pageUrl != '' }">
	<div class="row">
	<div class="col-sm-5">
			<div style="padding-top:20px">共${page.getPaginator().totalPages}页信息,${page.getPaginator().totalCount}条记录</div>
		</div>
	 <div class="col-sm-7">
			<div  style="text-align: right;"id="paginate">
				<ul class="pagination">
					<c:if test="${page.getPaginator().isHasPrePage() }">
						<li class="paginate_button previous" id="previous"><a
							href="${pageUrl }${page.getPaginator().page-1 }" aria-controls="page"
							data-dt-idx="0" tabindex="0">上一页</a></li>
					</c:if>

					<c:forEach var="i" begin="${begin }" end="${end }">
						<c:choose>
							<c:when test="${(i) == current }">
								<li class="paginate_button active"><a
									href="${pageUrl }${i}" aria-controls="page" data-dt-idx="1"
									tabindex="0">${i }</a></li>
							</c:when>
							<c:otherwise>
								<li class="paginate_button"><a href="${pageUrl }${i}"
									aria-controls="page" data-dt-idx="1" tabindex="0">${i }</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${page.getPaginator().isHasNextPage() }">
						<li class="paginate_button next" id="next"><a
							href="${pageUrl }${page.getPaginator().page+1 }" aria-controls="page"
							data-dt-idx="7" tabindex="0">下一页</a></li>
					</c:if>

				</ul>

			</div>
		</div>
	</div>
</c:if>

<script>
	$(function() {
		$(".inputpage").keyup(function() {
			//如果输入非数字，则替换为''，如果输入数字，
			this.value = this.value.replace(/[^\d]/g, '');
		})
		$('.inputpage').keydown(function(e) {
			if (e.keyCode == 13) {
				var page = $(this).val();
				if (page) {
					var total = $(".gopage").attr("data-total");
					if (total && parseInt(total) < parseInt(page)) {
						page = total;
					}
					window.location.href = $(".gopage").attr("data") + page;
				}
			}
		});
		$(".gopage").click(function() {
			var page = $(".inputpage").val();
			if (page) {
				var total = $(".gopage").attr("data-total");
				if (total && parseInt(total) < parseInt(page)) {
					page = parseInt(total);
				}
				window.location.href = $(this).attr("data") + page;
			}
		})
	})
</script>