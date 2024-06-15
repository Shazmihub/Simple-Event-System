package com.donativa.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.donativa.entity.Users;

@Repository
public interface UserRepository extends JpaRepository<Users, Long> {
  Optional<Users> findByEmailAndPassword(String username, String password);
  
  Users findByIdAndRole(long userId, String role);
  
  Boolean existsByEmail(String email);
  
  List<Users> findAllByRole(String role);
}
