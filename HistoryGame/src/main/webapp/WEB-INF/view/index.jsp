<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@include file="header.jsp" %>
 <style>
 .modal:before{vertical-align: middle;}
 .modal-dialog{vertical-align: middle;}
 
 </style>

  <!-- ======= Hero Section ======= -->
  <section id="hero" class="d-flex align-items-center" style="height:100vh;">
    <div class="container">
      <div class="row col-12">
        <div class="col-lg-6 d-flex flex-column justify-content-center pt-4 pt-lg-0 order-2 order-lg-1" data-aos="fade-up" data-aos-delay="200">
          
          <!-- <h2><i class="ri-play-fill"></i> 아래 버튼을 클릭해서 시작하렴!</h2> -->
          
        </div>
        <div class="col-lg-6 order-1 order-lg-2 hero-img m-4 text-center" data-aos="zoom-in" data-aos-delay="200">
          	<img src="assets/img/lol_white.png" class="img-fluid animated" alt="" style='width:100px;'>
        </div>
      </div>
    </div>
	
  </section><!-- End Hero -->
  
  <!-- control_modal -->
	<%@include file='./control_modal.jsp' %>
	<!-- control_modal -->
  
  <footer id='footer' class='position-absolute bottom-0 col-12 pb-2'>
  		<div class="d-flex justify-content-center justify-content-lg-start footer-top pt-0 pb-0 bg-transparent">
          	<!-- modal trigger -->
            <a href="#" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#main_btn_modal"><i class="ri-menu-line text-bolder"></i></i></a>
            <!-- modal trigger -->
        </div>
  </footer>
  
  <!-- <main id="main">

    ======= Clients Section =======
    <section id="clients" class="clients section-bg">
      <div class="container">
        <div class="row" data-aos="zoom-in">
		  <div class="col-3 d-flex align-items-center justify-content-center"></div>
          <div class="col-6 d-flex align-items-center justify-content-center">
            
          </div>
          <div class="col-3 d-flex align-items-center justify-content-center"></div>

          <div class="col-lg-2 col-md-4 col-6 d-flex align-items-center justify-content-center">
            <img src="assets/img/clients/client-2.png" class="img-fluid" alt="">
          </div>

          <div class="col-lg-2 col-md-4 col-6 d-flex align-items-center justify-content-center">
            <img src="assets/img/clients/client-3.png" class="img-fluid" alt="">
          </div>

          <div class="col-lg-2 col-md-4 col-6 d-flex align-items-center justify-content-center">
            <img src="assets/img/clients/client-4.png" class="img-fluid" alt="">
          </div>

          <div class="col-lg-2 col-md-4 col-6 d-flex align-items-center justify-content-center">
            <img src="assets/img/clients/client-5.png" class="img-fluid" alt="">
          </div>

          <div class="col-lg-2 col-md-4 col-6 d-flex align-items-center justify-content-center">
            <img src="assets/img/clients/client-6.png" class="img-fluid" alt="">
          </div>

        </div>

      </div>
    </section>End Cliens Section

    ======= About Us Section =======
    <section id="about" class="about">
      <div class="container" data-aos="fade-up">
      	<div class="row text-center">
      		<div class="col-3"></div>
			<img src="assets/img/earth_location.png" class="img col-6">
			<div class="col-3"></div>
		</div>
        <div class="section-title mt-2">
          <h2>우리는?</h2>
        </div>

        <div class="row content">
          <div class="col-lg-6">
            <p>
              Children have Somnium, they will meet the Viento, but finally Aeternam will reach them.
            </p>
            <ul>
              <li><i class="ri-check-double-line"></i> 우리는 특별하다! #1 </li>
              <li><i class="ri-check-double-line"></i> 우리는 소중하다! #2 </li>
              <li><i class="ri-check-double-line"></i> 우리는 누구도 대체할 수 없다! #3 </li>
            </ul>
          </div>
          <div class="col-lg-6 pt-4 pt-lg-0">
            <p>
              천천히 둘러봐주세요!<br/>
              자세한 내용은 하단에서 확인해주세요!<br/>
              감사합니다!<br/>
            </p>
            <a href="#" class="btn-learn-more">Learn More</a>
          </div>
        </div>

      </div>
    </section>End About Us Section

    ======= Why Us Section =======
    <section id="why-us" class="why-us section-bg">
      <div class="container-fluid" data-aos="fade-up">

        <div class="row">

          <div class="col-lg-7 d-flex flex-column justify-content-center align-items-stretch  order-2 order-lg-1">

            <div class="content text-center">
              <h3><small>더 나은 세계를 만들기 위한</small><br/><strong>역할</strong>과 <strong>책임</strong></h3>
              <p>
                세계인으로써 가져할 역할과 함꼐 책임의식을 배워봅시다! 
              </p>
            </div>

            <div class="accordion-list">
              <ul>
                <li>
                  <a data-bs-toggle="collapse" class="collapsed" data-bs-target="#accordion-list-1"><span>01</span> 중요한 첫번째는 뭘까요?? <i class="bx bx-chevron-down icon-show"></i><i class="bx bx-chevron-up icon-close"></i></a>
                  <div id="accordion-list-1" class="collapse" data-bs-parent=".accordion-list">
                    <p>
                      첫번째 아코디언에 대한 내용입니다.
                    </p>
                  </div>
                </li>

                <li>
                  <a data-bs-toggle="collapse" data-bs-target="#accordion-list-2" class="collapsed"><span>02</span> 중요한 두번째는 뭘까요? <i class="bx bx-chevron-down icon-show"></i><i class="bx bx-chevron-up icon-close"></i></a>
                  <div id="accordion-list-2" class="collapse" data-bs-parent=".accordion-list">
                    <p>
                      두번째 아코디언에 대한 내용입니다.
                    </p>
                  </div>
                </li>

                <li>
                  <a data-bs-toggle="collapse" data-bs-target="#accordion-list-3" class="collapsed"><span>03</span> 중요한 세번째는 뭘까요? <i class="bx bx-chevron-down icon-show"></i><i class="bx bx-chevron-up icon-close"></i></a>
                  <div id="accordion-list-3" class="collapse" data-bs-parent=".accordion-list">
                    <p>
                      세번째 아코디언에 대한 내용입니다.
                    </p>
                  </div>
                </li>

              </ul>
            </div>

          </div>

          <div class="col-lg-5 align-items-stretch order-1 order-lg-2 img" style='background-image: url("assets/img/love_society.jpg");' data-aos="zoom-in" data-aos-delay="150">&nbsp;</div>
        </div>

      </div>
    </section>End Why Us Section

   
    ======= Services Section =======
    <section id="services" class="services section-bg">
      <div class="container" data-aos="fade-up">

        <div class="section-title">
          <h2>Education Services</h2>
          <p>우리는 이런 교육을 제공할 수 있어요!</p>
        </div>

        <div class="row">
          <div class="col-xl-3 col-md-6 d-flex align-items-stretch" data-aos="zoom-in" data-aos-delay="100">
            <div class="icon-box">
              <div class="icon"><i class="bx bxl-dribbble"></i></div>
              <h4><a>세계시민교육</a></h4>
              <p>지구촌 친구와 가족을 이해하고 돕기 위한 정서적, 지식적 마인드를 개발해요!</p>
            </div>
          </div>

          <div class="col-xl-3 col-md-6 d-flex align-items-stretch mt-4 mt-md-0" data-aos="zoom-in" data-aos-delay="200">
            <div class="icon-box">
              <div class="icon"><i class="bx bx-file"></i></div>
              <h4><a>자기계발 및 성취감 교육</a></h4>
              <p>자신안의 가능성과 잠재력을 경험하고 개발시키며 집중해볼 수 있어요!</p>
            </div>
          </div>

          <div class="col-xl-3 col-md-6 d-flex align-items-stretch mt-4 mt-xl-0" data-aos="zoom-in" data-aos-delay="300">
            <div class="icon-box">
              <div class="icon"><i class="bx bx-tachometer"></i></div>
              <h4><a>관계형성 교육</a></h4>
              <p>나를 포함한 '우리'에 대해서 생각하고 느껴볼 수 있습니다!</p>
            </div>
          </div>
        </div>
      </div>
    </section>End Services Section

    ======= Cta Section =======
    <section id="cta" class="cta">
      <div class="container" data-aos="zoom-in">

        <div class="row">
          <div class="col-lg-9 text-center text-lg-start">
            <h3>교육문의하기</h3>
            <p> 다양하고 감각적인 교육, 한사람 한사람에게 소중하게 간직될 수 있는 교육을 신청할 수 있습니다!</p>
          </div>
          <div class="col-lg-3 cta-btn-container text-center">
            <a class="cta-btn align-middle" href="/get_estimate">문의하기</a>
          </div>
        </div>
      </div>
    </section>End Cta Section

    ======= Portfolio Section =======
    <section id="portfolio" class="portfolio">
      <div class="container" data-aos="fade-up">

        <div class="section-title">
          <h2>Education History</h2>
          <p>함께 했던 소중한 순간들</p>
        </div>

        <ul id="portfolio-flters" class="d-flex justify-content-center" data-aos="fade-up" data-aos-delay="100">
          <li data-filter="*" class="filter-active">All</li>
          <li data-filter=".filter-class">Class</li>
          <li data-filter=".filter-activity">Activity</li>
          <li data-filter=".filter-counseling">Counseling</li>
        </ul>

        <div class="row portfolio-container" data-aos="fade-up" data-aos-delay="200">

          <div class="col-lg-4 col-md-6 portfolio-item filter-class">
            <div class="portfolio-img"><img src="assets/img/class_image_1.jpg" class="img-fluid" alt=""></div>
            <div class="portfolio-info">
              <h4>Class 1</h4>
              <p>Class</p>
              <a href="assets/img/class_image_1.jpg" data-gallery="portfolioGallery" class="portfolio-lightbox preview-link" title="Class 1"><i class="bx bx-plus"></i></a>
              <a href="portfolio-details.html" class="details-link" title="More Details"><i class="bx bx-link"></i></a>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 portfolio-item filter-activity">
            <div class="portfolio-img"><img src="assets/img/activity_image_3.jpg" class="img-fluid" alt=""></div>
            <div class="portfolio-info">
              <h4>Activity 3</h4>
              <p>Activity</p>
              <a href="assets/img/activity_image_3.jpg" data-gallery="portfolioGallery" class="portfolio-lightbox preview-link" title="Activity 3"><i class="bx bx-plus"></i></a>
              <a href="portfolio-details.html" class="details-link" title="More Details"><i class="bx bx-link"></i></a>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 portfolio-item filter-class">
            <div class="portfolio-img"><img src="assets/img/class_image_2.jpg" class="img-fluid" alt=""></div>
            <div class="portfolio-info">
              <h4>Class 2</h4>
              <p>Class</p>
              <a href="assets/img/class_image_2.jpg" data-gallery="portfolioGallery" class="portfolio-lightbox preview-link" title="Class 2"><i class="bx bx-plus"></i></a>
              <a href="portfolio-details.html" class="details-link" title="More Details"><i class="bx bx-link"></i></a>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 portfolio-item filter-counseling">
            <div class="portfolio-img"><img src="assets/img/cs_image_2.jpg" class="img-fluid" alt=""></div>
            <div class="portfolio-info">
              <h4>Counseling 2</h4>
              <p>Counseling</p>
              <a href="assets/img/cs_image_2.jpg" data-gallery="portfolioGallery" class="portfolio-lightbox preview-link" title="Counseling 2"><i class="bx bx-plus"></i></a>
              <a href="portfolio-details.html" class="details-link" title="More Details"><i class="bx bx-link"></i></a>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 portfolio-item filter-activity">
            <div class="portfolio-img"><img src="assets/img/activity_image_2.jpg" class="img-fluid" alt=""></div>
            <div class="portfolio-info">
              <h4>Activity 2</h4>
              <p>Activity</p>
              <a href="assets/img/activity_image_2.jpg" data-gallery="portfolioGallery" class="portfolio-lightbox preview-link" title="Activity 2"><i class="bx bx-plus"></i></a>
              <a href="portfolio-details.html" class="details-link" title="More Details"><i class="bx bx-link"></i></a>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 portfolio-item filter-class">
            <div class="portfolio-img"><img src="assets/img/class_image_3.jpg" class="img-fluid" alt=""></div>
            <div class="portfolio-info">
              <h4>Class 3</h4>
              <p>Class</p>
              <a href="assets/img/class_image_3.jpg" data-gallery="portfolioGallery" class="portfolio-lightbox preview-link" title="Class 3"><i class="bx bx-plus"></i></a>
              <a href="portfolio-details.html" class="details-link" title="More Details"><i class="bx bx-link"></i></a>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 portfolio-item filter-counseling">
            <div class="portfolio-img"><img src="assets/img/cs_image_1.jpg" class="img-fluid" alt=""></div>
            <div class="portfolio-info">
              <h4>Counseling 1</h4>
              <p>Counseling</p>
              <a href="assets/img/cs_image_1.jpg" data-gallery="portfolioGallery" class="portfolio-lightbox preview-link" title="Counseling 1"><i class="bx bx-plus"></i></a>
              <a href="portfolio-details.html" class="details-link" title="More Details"><i class="bx bx-link"></i></a>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 portfolio-item filter-counseling">
            <div class="portfolio-img"><img src="assets/img/cs_image_3.jpg" class="img-fluid" alt=""></div>
            <div class="portfolio-info">
              <h4>Counseling 3</h4>
              <p>Counseling</p>
              <a href="assets/img/cs_image_3.jpg" data-gallery="portfolioGallery" class="portfolio-lightbox preview-link" title="Counseling 3"><i class="bx bx-plus"></i></a>
              <a href="portfolio-details.html" class="details-link" title="More Details"><i class="bx bx-link"></i></a>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 portfolio-item filter-activity">
            <div class="portfolio-img"><img src="assets/img/activity_image_1.jpg" class="img-fluid" alt=""></div>
            <div class="portfolio-info">
              <h4>Activity 1</h4>
              <p>Activity</p>
              <a href="assets/img/activity_image_1.jpg" data-gallery="portfolioGallery" class="portfolio-lightbox preview-link" title="Activity 3"><i class="bx bx-plus"></i></a>
              <a href="portfolio-details.html" class="details-link" title="More Details"><i class="bx bx-link"></i></a>
            </div>
          </div>

        </div>

      </div>
    </section>End Portfolio Section

    ======= Team Section =======
    <section id="team" class="team section-bg">
      <div class="container" data-aos="fade-up">

        <div class="section-title">
          <h2>팀메이트</h2>
          <p>우리는 관계가 중시되는 혁신적인 교육을 지향하는 최고의 교육팀입니다.</p>
        </div>

        <div class="row">
          <div class="col-lg-6">
            <div class="member d-flex align-items-start" data-aos="zoom-in" data-aos-delay="100">
              <div class="pic"><img src="assets/img/team/team-1.jpg" class="img-fluid" alt=""></div>
              <div class="member-info">
                <h4>Walter White</h4>
                <span>Chief Executive Officer</span>
                <p>Explicabo voluptatem mollitia et repellat qui dolorum quasi</p>
                <div class="social">
                  <a href=""><i class="ri-twitter-fill"></i></a>
                  <a href=""><i class="ri-facebook-fill"></i></a>
                  <a href=""><i class="ri-instagram-fill"></i></a>
                  <a href=""> <i class="ri-linkedin-box-fill"></i> </a>
                </div>
              </div>
            </div>
          </div>
        </div>

      </div>
    </section>End Team Section

    
    ======= Frequently Asked Questions Section =======
    <section id="faq" class="faq section-bg">
      <div class="container" data-aos="fade-up">

        <div class="section-title">
          <h2>FAQ</h2>
        </div>

        <div class="faq-list">
          <ul>
            <li data-aos="fade-up" data-aos-delay="100">
              <i class="bx bx-help-circle icon-help"></i> <a data-bs-toggle="collapse" class="collapsed" data-bs-target="#faq-list-1">자주 묻는 질문 1 <i class="bx bx-chevron-down icon-show"></i><i class="bx bx-chevron-up icon-close"></i></a>
              <div id="faq-list-1" class="collapse" data-bs-parent=".faq-list">
                <p>
                  자주 묻는 질문 답변 1
                </p>
              </div>
            </li>

            <li data-aos="fade-up" data-aos-delay="200">
              <i class="bx bx-help-circle icon-help"></i> <a data-bs-toggle="collapse" data-bs-target="#faq-list-2" class="collapsed">자주 묻는 질문 2 <i class="bx bx-chevron-down icon-show"></i><i class="bx bx-chevron-up icon-close"></i></a>
              <div id="faq-list-2" class="collapse" data-bs-parent=".faq-list">
                <p>
                  자주 묻는 질문 답변 2
                </p>
              </div>
            </li>

            <li data-aos="fade-up" data-aos-delay="300">
              <i class="bx bx-help-circle icon-help"></i> <a data-bs-toggle="collapse" data-bs-target="#faq-list-3" class="collapsed">자주 묻는 질문 3<i class="bx bx-chevron-down icon-show"></i><i class="bx bx-chevron-up icon-close"></i></a>
              <div id="faq-list-3" class="collapse" data-bs-parent=".faq-list">
                <p>
                  자주 묻는 질문 답변 3
                </p>
              </div>
            </li>

            <li data-aos="fade-up" data-aos-delay="400">
              <i class="bx bx-help-circle icon-help"></i> <a data-bs-toggle="collapse" data-bs-target="#faq-list-4" class="collapsed">자주 묻는 질문 4 <i class="bx bx-chevron-down icon-show"></i><i class="bx bx-chevron-up icon-close"></i></a>
              <div id="faq-list-4" class="collapse" data-bs-parent=".faq-list">
                <p>
                  자주 묻는 질문 답변 4
                </p>
              </div>
            </li>
          </ul>
        </div>

      </div>
    </section>End Frequently Asked Questions Section

    ======= Contact Section =======
    <section id="contact" class="contact">
      <div class="container" data-aos="fade-up">

        <div class="section-title">
          <h2>Contact</h2>
        </div>

        <div class="row">

          <div class="col-lg-5 d-flex align-items-stretch">
            <div class="info">
              <div class="address">
                <i class="bi bi-geo-alt"></i>
                <h4>Location:</h4>
                <p>A108 Adam Street, New York, NY 535022</p>
              </div>

              <div class="email">
                <i class="bi bi-envelope"></i>
                <h4>Email.</h4>
                <p>MyEmail@AmorStella.com</p>
              </div>

              <div class="phone">
                <i class="bi bi-phone"></i>
                <h4>Mobile.</h4>
                <p>+82 10 1234 5678</p>
              </div>

              <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d12097.433213460943!2d-74.0062269!3d40.7101282!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0xb89d1fe6bc499443!2sDowntown+Conference+Center!5e0!3m2!1smk!2sbg!4v1539943755621" frameborder="0" style="border:0; width: 100%; height: 290px;" allowfullscreen></iframe>
              <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d101237.6429777211!2d126.84514707706934!3d37.53912612434426!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357b61e1f72c147b%3A0xbd134b835e4f1ac7!2z66Gv642w7Yyp7Yag66as7JWE7Jq466CbIOqwgOyCsOygkA!5e0!3m2!1sko!2skr!4v1662439049130!5m2!1sko!2skr" frameborder="0" width="100%" height="290px;" style="border:0;" allowfullscreen></iframe>
            </div>
          </div>
          <div class="col-lg-7 mt-5 mt-lg-0 d-flex align-items-stretch">
            <form action="forms/contact.php" method="post" role="form" class="php-email-form">
              <div class="row">
                <div class="form-group col-md-6">
                  <label for="name">Your Name</label>
                  <input type="text" name="name" class="form-control" id="name" required>
                </div>
                <div class="form-group col-md-6">
                  <label for="name">Your Email</label>
                  <input type="email" class="form-control" name="email" id="email" required>
                </div>
              </div>
              <div class="form-group">
                <label for="name">Subject</label>
                <input type="text" class="form-control" name="subject" id="subject" required>
              </div>
              <div class="form-group">
                <label for="name">Message</label>
                <textarea class="form-control" name="message" rows="10" required></textarea>
              </div>
              <div class="my-3">
                <div class="loading">Loading</div>
                <div class="error-message"></div>
                <div class="sent-message">Your message has been sent. Thank you!</div>
              </div>
              <div class="text-center"><button type="submit">Send Message</button></div>
            </form>
          </div>

        </div>

      </div>
    </section>End Contact Section

  </main>End #main
 -->
  
  <div id="preloader"></div>
  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>	
   
  <!-- Vendor JS Files -->
  <script src="assets/vendor/aos/aos.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="assets/vendor/waypoints/noframework.waypoints.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>

</body>

</html>