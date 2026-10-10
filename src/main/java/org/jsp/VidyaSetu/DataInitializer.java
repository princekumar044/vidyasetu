package org.jsp.VidyaSetu;

import org.jsp.VidyaSetu.dto.Course;
import org.jsp.VidyaSetu.dto.Student;
import org.jsp.VidyaSetu.repository.CourseRepo;
import org.jsp.VidyaSetu.repository.StudentRepo;
import org.jsp.VidyaSetu.util.PasswordUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import java.math.BigDecimal;

@Component
public class DataInitializer implements CommandLineRunner {
    
    @Autowired
    private CourseRepo courseRepo;
    
    @Autowired
    private StudentRepo studentRepo;
    
    @Override
    public void run(String... args) throws Exception {
        // Add sample courses if none exist
        if (courseRepo.count() == 0) {
            
            // Python Programming
            Course course1 = new Course(
                "Python Programming",
                "PY101",
                "Learn Python programming from basics to advanced concepts including OOP, data structures, and web development.",
                "Alex Johnson",
                "3 Months",
                new BigDecimal("9000.00"),
                "Programming"
            );
            
            // Java Programming
            Course course2 = new Course(
                "Java Programming",
                "JAV101",
                "Master Java programming, Spring Framework, Hibernate, and enterprise application development.",
                "Michael Chen",
                "3.5 Months",
                new BigDecimal("12000.00"),
                "Programming"
            );
            
            // C++ Programming
            Course course3 = new Course(
                "C++ Programming",
                "CPP101",
                "Learn C++ programming with focus on system programming, game development, and performance optimization.",
                "Robert Williams",
                "2.5 Months",
                new BigDecimal("8500.00"),
                "Programming"
            );
            
            // C# Programming
            Course course4 = new Course(
                "C# Programming",
                "CSHARP101",
                "Master C# programming for Windows applications, game development with Unity, and .NET framework.",
                "Jennifer Davis",
                "3 Months",
                new BigDecimal("11000.00"),
                "Programming"
            );
            
            // Full Stack Development
            Course course5 = new Course(
                "Full Stack Development",
                "FSD101",
                "Become a full stack developer with MERN stack (MongoDB, Express.js, React.js, Node.js) and modern web technologies.",
                "David Miller",
                "4 Months",
                new BigDecimal("18000.00"),
                "Full Stack"
            );
            
            // MERN Stack
            Course course6 = new Course(
                "MERN Stack Development",
                "MERN201",
                "Specialize in MERN stack for building modern, scalable web applications with React and Node.js.",
                "Sarah Wilson",
                "3.5 Months",
                new BigDecimal("16000.00"),
                "Full Stack"
            );
            
            // Java Full Stack
            Course course7 = new Course(
                "Java Full Stack Development",
                "JFSD301",
                "Master full stack development with Java, Spring Boot, React, and MySQL. Build enterprise-level applications.",
                "John Smith",
                "4 Months",
                new BigDecimal("20000.00"),
                "Full Stack"
            );
            
            // React.js
            Course course8 = new Course(
                "React.js Development",
                "REACT101",
                "Build modern, responsive web applications using React.js, Redux, Hooks, and Material-UI.",
                "Mike Wilson",
                "2.5 Months",
                new BigDecimal("13000.00"),
                "Frontend"
            );
            
            // Angular.js
            Course course9 = new Course(
                "Angular.js Development",
                "ANGULAR101",
                "Master Angular framework for building scalable single-page applications with TypeScript.",
                "Emily Brown",
                "3 Months",
                new BigDecimal("14000.00"),
                "Frontend"
            );
            
            // Spring Boot
            Course course10 = new Course(
                "Spring Boot & Microservices",
                "SPRING101",
                "Learn to build scalable microservices with Spring Boot, Spring Cloud, and REST APIs.",
                "Thomas Anderson",
                "3 Months",
                new BigDecimal("15000.00"),
                "Backend"
            );
            
            // Hibernate
            Course course11 = new Course(
                "Hibernate Framework",
                "HIBERNATE101",
                "Master Hibernate ORM for Java, database interactions, and object-relational mapping techniques.",
                "Jessica Taylor",
                "2 Months",
                new BigDecimal("10000.00"),
                "Backend"
            );
            
            // Django
            Course course12 = new Course(
                "Django Web Development",
                "DJANGO101",
                "Build web applications using Django framework, Python, and PostgreSQL for backend development.",
                "Kevin Martin",
                "2.5 Months",
                new BigDecimal("12000.00"),
                "Backend"
            );
            
            // Linux
            Course course13 = new Course(
                "Linux Administration",
                "LINUX101",
                "Master Linux operating system, command line, system administration, and server management.",
                "Linda Garcia",
                "2 Months",
                new BigDecimal("8000.00"),
                "System"
            );
            
            // Kubernetes
            Course course14 = new Course(
                "Kubernetes & Docker",
                "K8S101",
                "Learn container orchestration with Kubernetes, Docker containerization, and cloud deployment.",
                "Daniel Moore",
                "2.5 Months",
                new BigDecimal("14000.00"),
                "DevOps"
            );
            
            // DevOps
            Course course15 = new Course(
                "DevOps & CI/CD Pipeline",
                "DEVOPS101",
                "Master DevOps practices with Jenkins, Docker, Kubernetes, and AWS deployment strategies.",
                "Emily Brown",
                "3 Months",
                new BigDecimal("16000.00"),
                "DevOps"
            );
            
            // MongoDB
            Course course16 = new Course(
                "MongoDB Database",
                "MONGODB101",
                "Learn NoSQL database management with MongoDB, data modeling, aggregation, and performance tuning.",
                "Brian Thompson",
                "1.5 Months",
                new BigDecimal("9000.00"),
                "Database"
            );
            
            // AWS Cloud
            Course course17 = new Course(
                "AWS Cloud Computing",
                "AWS101",
                "Master Amazon Web Services including EC2, S3, Lambda, RDS, and cloud architecture design.",
                "Patricia Harris",
                "3 Months",
                new BigDecimal("17000.00"),
                "Cloud"
            );
            
            // Save all courses
            courseRepo.save(course1);
            courseRepo.save(course2);
            courseRepo.save(course3);
            courseRepo.save(course4);
            courseRepo.save(course5);
            courseRepo.save(course6);
            courseRepo.save(course7);
            courseRepo.save(course8);
            courseRepo.save(course9);
            courseRepo.save(course10);
            courseRepo.save(course11);
            courseRepo.save(course12);
            courseRepo.save(course13);
            courseRepo.save(course14);
            courseRepo.save(course15);
            courseRepo.save(course16);
            courseRepo.save(course17);
            
            System.out.println("✓ Created 17 sample courses");
        }
        
        // Add admin user if none exists
        if (studentRepo.count() == 0) {
            // Create SUPER ADMIN user with professional name
            Student superAdmin = new Student();
            superAdmin.setFullname("System Administrator");
            superAdmin.setEmail("admin@studentportal.com");
            superAdmin.setPassword(PasswordUtil.encryptPassword("Admin@123"));
            superAdmin.setAddress("System Headquarters");
            superAdmin.setRole("ADMIN");
            studentRepo.save(superAdmin);
            
            // Create additional admin user
            Student courseAdmin = new Student();
            courseAdmin.setFullname("Course Manager");
            courseAdmin.setEmail("manager@studentportal.com");
            courseAdmin.setPassword(PasswordUtil.encryptPassword("Manager@123"));
            courseAdmin.setAddress("Course Management Department");
            courseAdmin.setRole("ADMIN");
            studentRepo.save(courseAdmin);
            
            // Create sample students
            Student student1 = new Student();
            student1.setFullname("John Smith");
            student1.setEmail("john.smith@example.com");
            student1.setPassword(PasswordUtil.encryptPassword("Student@123"));
            student1.setAddress("123 Main Street, New York");
            student1.setRole("STUDENT");
            studentRepo.save(student1);
            
            Student student2 = new Student();
            student2.setFullname("Emma Johnson");
            student2.setEmail("emma.j@example.com");
            student2.setPassword(PasswordUtil.encryptPassword("Student@456"));
            student2.setAddress("456 Oak Avenue, California");
            student2.setRole("STUDENT");
            studentRepo.save(student2);
            
            Student student3 = new Student();
            student3.setFullname("Michael Brown");
            student3.setEmail("michael.b@example.com");
            student3.setPassword(PasswordUtil.encryptPassword("Student@789"));
            student3.setAddress("789 Pine Road, Texas");
            student3.setRole("STUDENT");
            studentRepo.save(student3);
            
            System.out.println("✓ Created 2 admin users and 3 sample students");
            System.out.println("==============================================");
            System.out.println("ADMIN CREDENTIALS:");
            System.out.println("1. Super Admin: admin@studentportal.com / Admin@123");
            System.out.println("2. Course Manager: manager@studentportal.com / Manager@123");
            System.out.println("STUDENT CREDENTIALS:");
            System.out.println("1. John Smith: john.smith@example.com / Student@123");
            System.out.println("2. Emma Johnson: emma.j@example.com / Student@456");
            System.out.println("3. Michael Brown: michael.b@example.com / Student@789");
            System.out.println("==============================================");
        }
    }
}