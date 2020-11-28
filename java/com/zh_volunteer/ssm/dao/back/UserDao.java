package com.zh_volunteer.ssm.dao.back;

import com.zh_volunteer.ssm.pojo.Activity;
import com.zh_volunteer.ssm.pojo.User;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.type.JdbcType;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserDao {
    /**
     * 查询所有用户
     * @throws Exception
     */
    void queryAll() throws Exception;
    /**
     * 查询一个用户通过id
     * @param stu_id
     * @throws Exception
     */
    @Select("select * from tb_user where stu_id = #{stu_id}")
    @Results(id = "selectUser",value = {
            @Result(column="phone_num", property="phone_num", jdbcType= JdbcType.VARCHAR),
            @Result(column="limit_id", property="limit_id", jdbcType= JdbcType.VARCHAR),
            @Result(column="stu_id", property="stu_id", jdbcType= JdbcType.VARCHAR),
            @Result(column="state_id", property="state_id", jdbcType=JdbcType.CHAR)
    })
    User queryOneUserByStuId(String stu_id) throws Exception;
    /**
     * 用户登录
     * @param username
     * @param password
     * @return
     * @throws Exception
     */
    @Select("select id,username,password,gender,phone_num,limit_id,stu_id,state_id,tie from tb_user where (stu_id=#{username} OR phone_num=#{username}) AND password=#{password} and limit_id=4")
    @ResultMap(value="selectUser")
    User login(@Param("username") String username, @Param("password") String password) throws Exception;
    /**
     * 查询所有用户
     * @return
     * @throws Exception
     */
    @Select("select * from tb_user LIMIT 0,10")
    @ResultMap(value="selectUser")
    List<User> findAll() throws Exception;
    /**
     * 添加用户
     * @param user
     * @throws Exception
     */
    @Insert("insert into tb_user(username,password,gender,phone_num,limit_id,stu_id,state_id,tie) values(#{username},#{password},#{gender},#{phone_num},#{limit_id},#{stu_id},#{state_id},#{tie})")
    void addOneUser(User user) throws Exception;

    /**
     * 修改用户信息
     * @param user
     * @throws Exception
     */
    @Update("update tb_user set username=#{username},gender=#{gender},phone_num=#{phone_num},stu_id=#{stu_id} where id=#{id}")
    void updateUserInfo(User user) throws Exception;
    /**
     * 删除用户信息
     * @param stu_id
     * @throws Exception
     */
    @Delete("delete from tb_user where stu_id=#{stu_id}")
    void deleteUserInfo(String stu_id) throws Exception;
    /**
     * 修改用户角色信息
     * @param role_id
     * @param stu_id
     */
    @Update("update tb_user set limit_id=#{role_id} where stu_id=#{stu_id}")
    void updateUserRoleInfo(@Param("role_id") Integer role_id, @Param("stu_id") String stu_id);

    @Insert("insert into tb_activity(creator,time,state,activity_name,activity_introduce,activity_details,activity_remarks,tie,activity_type,photo_path,activity_total_number,activity_current_number) values(#{creator},#{time},#{state},#{activity_name},#{activity_introduce},#{activity_details},#{activity_remarks},#{tie},#{activity_type},#{photo_path},#{activity_total_number},#{activity_current_number})")
    void addOneActivity(Activity activity);

    @Select("SELECT * FROM tb_user WHERE stu_Id LIKE  CONCAT('%',#{finalNum},'%') OR username LIKE  CONCAT('%',#{finalStr},'%') limit 0,10")
    @ResultMap(value="selectUser")
    List<User> charBoxByUsernameOrStuId(@Param("finalNum") String finalNum, @Param("finalStr") String finalStr);

    @Select("SELECT count(*) FROM tb_user WHERE stu_Id LIKE  CONCAT('%',#{finalNum},'%') OR username LIKE  CONCAT('%',#{finalStr},'%')")
    Integer charBoxByUsernameOrStuIdCount(@Param("finalNum") String finalNum, @Param("finalStr") String finalStr);

    @Select("select count(*) from tb_user")
    Integer findAllCount();

    @Select("select * from tb_user LIMIT #{page},10")
    @ResultMap(value="selectUser")
    List<User> pageFindByPageNum(Integer page);

    @Select(" SELECT * FROM tb_user WHERE stu_Id LIKE CONCAT('%',#{finalNum},'%') OR username LIKE CONCAT('%',#{finalStr},'%') LIMIT #{page},10")
    @ResultMap(value="selectUser")
    List<User> pageFindByPageNumAndSearchContent(@Param("finalNum") String finalNum, @Param("finalStr") String finalStr,@Param("page") Integer page);

    @Update("update tb_user set password='000000' where stu_id=#{stu_id}")
    void reSetPaaWord(String stu_id);
}
