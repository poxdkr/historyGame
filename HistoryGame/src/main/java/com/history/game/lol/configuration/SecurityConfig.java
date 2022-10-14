package com.history.game.lol.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import com.history.game.lol.service.LoginIdPwValidator;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter{
	
	@Autowired
	private LoginIdPwValidator loginIdPwValidator;
	
	@Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .authorizeRequests() // 요청에 의한 보안검사 시작
                //.antMatchers("/","/login","/failure","/registUser","/registPage","/get_estimate","/assets/**","/static","/send_est","/search_est").permitAll()
                .antMatchers("/**").permitAll()
                .antMatchers("/admin").hasRole("admin")
                .anyRequest().authenticated() //어떤 요청에도 보안검사를 한다.
        .and()
                .formLogin()//보안 검증은 formLogin방식으로 하겠다.
        		.loginPage("/login")
        		.loginProcessingUrl("/loginProc")
				.usernameParameter("userid")
        		.passwordParameter("pw")
        		.defaultSuccessUrl("/loginSuccess", true)
        		.failureUrl("/loginFailure")
        		.permitAll()
       .and()
       			.logout()
       			.logoutRequestMatcher(new AntPathRequestMatcher("/logout")) //로그아웃 매핑
       			.invalidateHttpSession(true); //로그아웃시 세션 날리기
        
        //security.httpBasic().disable();		
        http.cors().and();		
        http.csrf().disable();
        
        //x-frame
        http.headers()
			.frameOptions().sameOrigin();
        
        //exception handling - > denied Page config
        http.exceptionHandling().accessDeniedPage("/error/403");
        			
    }
	 @Override
	    public void configure(WebSecurity web) throws Exception {
	        web.ignoring().antMatchers("/resource/**"); //정적리소스는 모두 접근 허용
	    }
	 
	 @Override
	    public void configure(AuthenticationManagerBuilder auth) throws Exception {
	        auth.userDetailsService(loginIdPwValidator); //인증 시작
	    }
}
