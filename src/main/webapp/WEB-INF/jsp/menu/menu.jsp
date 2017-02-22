
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<li class="treeview">
  <a href="welcome" target="contentArea"mname="首页" class="leafMenu">
      <i class="fa fa-circle-o"></i> 
         <span>首页</span>
  </a>
</li>

<li class="treeview">
   <a href="#"> 
        <i class="fa fa-folder"></i>
		   <span>系统管理</span> 
		<i class="fa fa-angle-left pull-right"></i>
   </a>
	<ul class="treeview-menu">
	   <li>
	       <a href="/system/user/list" target="contentArea" class="leafMenu" mname="帐号管理">
	         <i class="fa fa-circle-o"></i> 帐号管理
		   </a>
	   </li>
	</ul> 
</li>	
</li>