package com.tourism.dao;

import com.tourism.model.Package;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PackageDAO {

    public List<Package> getAllPackages() {
        List<Package> packageList = new ArrayList<>();
        String sql = "SELECT * FROM packages";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Package pkg = new Package();
                pkg.setId(rs.getInt("id"));
                pkg.setName(rs.getString("name"));
                pkg.setDescription(rs.getString("description"));
                pkg.setPrice(rs.getDouble("price"));
                pkg.setDurationDays(rs.getInt("duration_days"));
                pkg.setImageUrl(rs.getString("image_url"));
                packageList.add(pkg);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return packageList;
    }
    
 // Add this new method to your existing PackageDAO class
    public Package getPackageById(int packageId) {
        Package pkg = null;
        String sql = "SELECT * FROM packages WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, packageId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                pkg = new Package();
                pkg.setId(rs.getInt("id"));
                pkg.setName(rs.getString("name"));
                pkg.setDescription(rs.getString("description"));
                pkg.setPrice(rs.getDouble("price"));
                // ... set other fields if needed
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pkg;
    }
}