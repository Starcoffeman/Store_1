package org.example.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Autowired
    private CustomUserDetailsService userDetailsService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Bean
    public AuthenticationManager authManager(HttpSecurity http) throws Exception {
        AuthenticationManagerBuilder authenticationManagerBuilder =
                http.getSharedObject(AuthenticationManagerBuilder.class);
        authenticationManagerBuilder
                .userDetailsService(userDetailsService)
                .passwordEncoder(passwordEncoder);
        return authenticationManagerBuilder.build();
    }

    @Bean
    public AuthenticationSuccessHandler authenticationSuccessHandler() {
        SimpleUrlAuthenticationSuccessHandler handler = new SimpleUrlAuthenticationSuccessHandler();
        handler.setDefaultTargetUrl("/");
        handler.setAlwaysUseDefaultTargetUrl(true);
        return handler;
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(auth -> auth
                        // Публичные страницы
                        .requestMatchers("/", "/main", "/login", "/register", "/sale", "/catalog", "/cart").permitAll()
                        .requestMatchers("/products/**", "/articles/**").permitAll()
                        .requestMatchers("/category/**", "/css/**", "/js/**", "/images/**", "/base.css", "/css/main.css").permitAll()
                        .requestMatchers("/error", "/error/**", "/404").permitAll()
                        .requestMatchers("/favorites", "/favorites/**").permitAll()

                        // ========== НОВЫЕ СТРАНИЦЫ ФУТЕРА (ОБЩЕДОСТУПНЫЕ) ==========
                        .requestMatchers("/delivery", "/returns", "/warranty", "/faq").permitAll()
                        .requestMatchers("/about", "/contacts", "/blog", "/vacancies").permitAll()
                        .requestMatchers("/news/**").permitAll()
                        .requestMatchers("/cart/count", "/favorites/count").permitAll()
                        // Блог - публичный доступ
                        .requestMatchers("/blog", "/blog/**", "/blog/category/**", "/blog/search").permitAll()
                        .requestMatchers("/api/articles/**").permitAll()
                        // ============================================================

                        // Страницы заказов ДЛЯ ПОЛЬЗОВАТЕЛЕЙ (доступны авторизованным)
                        .requestMatchers("/orders/profile/**", "/orders/success/**", "/orders/*/success").authenticated()
                        .requestMatchers("/orders/my/**").authenticated()



                        // Админские страницы (все остальные /orders/** требуют ADMIN)
                        .requestMatchers("/admin/**").hasRole("ADMIN")
                        .requestMatchers("/orders/**").hasRole("ADMIN")
                        .requestMatchers("/category/add/**", "/category/edit/**", "/category/delete/**").hasRole("ADMIN")
                        .requestMatchers("/products/add/**", "/products/edit/**", "/products/delete/**").hasRole("ADMIN")
                        .requestMatchers("/reviews/add/**", "/reviews/edit/**", "/reviews/delete/**").hasRole("ADMIN")

                        // Страницы пользователя
                        .requestMatchers("/users/profile").authenticated()
                        .requestMatchers("/cart/checkout").authenticated()
                        .requestMatchers("/checkout", "/checkout/**").authenticated()
                        .requestMatchers("/reviews/main").authenticated()

                        .anyRequest().authenticated()
                )
                .formLogin(form -> form
                        .loginPage("/login")
                        .loginProcessingUrl("/login")
                        .defaultSuccessUrl("/", true)
                        .successHandler(authenticationSuccessHandler())
                        .failureUrl("/login?error=true")
                        .permitAll()
                )
                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/login?logout=true")
                        .invalidateHttpSession(true)
                        .deleteCookies("JSESSIONID")
                        .permitAll()
                )
                .csrf(csrf -> csrf
                        .ignoringRequestMatchers("/logout", "/cart/add", "/cart/update", "/cart/remove/**", "/cart/clear", "/favorites/add/**", "/favorites/remove/**", "/favorites/clear", "/checkout/submit")
                )
                .sessionManagement(session -> session
                        .sessionFixation().migrateSession()
                        .maximumSessions(1)
                        .expiredUrl("/login?expired=true")
                );

        return http.build();
    }
}