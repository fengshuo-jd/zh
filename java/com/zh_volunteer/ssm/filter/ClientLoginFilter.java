package com.zh_volunteer.ssm.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class ClientLoginFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest)servletRequest;
        HttpServletResponse response = (HttpServletResponse)servletResponse;
        HttpSession session = request.getSession();

        if(session.getAttribute("user") == null){
            System.out.println("filter false" + session.getAttribute("password"));
            // 没有登录
            response.sendRedirect(request.getContextPath()+"/resources/pages/Client/client_fist_page.jsp");
        }else{
            System.out.println("filter true" + session.getAttribute("user"));
            // 已经登录，继续请求下一级资源（继续访问）
            filterChain.doFilter(servletRequest, servletResponse);
        }

    }

    @Override
    public void destroy() {

    }
}
