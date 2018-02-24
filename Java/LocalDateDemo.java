import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.temporal.TemporalAdjusters;

/**
 * 为什么需要一个新的日期时间库
 * 1.java.util.Date，SimpleDateFormatter线程不安全
 * 2.java.util.Date年从1900年开始，月从1开始，日从0开始，不直观
 *
 * 以上和其他一些问题导致第三方的日期时间包很流行，比如Joda-Time
 * 最后由Joda-Time的作者与Oracle共同发起新的项目，往java8中加入新的类
 *
 * 新的API基于以下思路
 * 1.不可变类
 *
 */
public class Test {
    public static void main(String[] args) {

        LocalDate today = LocalDate.now();

        LocalDate christmas = LocalDate.of(2014, 12, 25);

        LocalDate endOfFeb = LocalDate.parse("2014-02-28");

        LocalDate firstDayOfThisMonth = today.with(TemporalAdjusters.firstDayOfMonth());

        LocalDate secondDayOfThisMonth = today.withDayOfMonth(2);

        LocalDate lastDayOfThisMonth = today.with(TemporalAdjusters.lastDayOfMonth());

        LocalDate firstDayOf2015 = lastDayOfThisMonth.plusDays(1);

        LocalDate firstMondayOf2015 = LocalDate.parse("2015-01-01").with(TemporalAdjusters.firstInMonth(DayOfWeek.MONDAY));

        LocalTime now = LocalTime.now();

        now = now.withNano(0);

        LocalTime zero = LocalTime.of(0, 0, 0);

        LocalTime mid = LocalTime.of(12, 0, 0);

        LocalTime.of(17, 18, 21);

        // LocalDateTime 与 java.sql.TimeStamp 的转换
        LocalDateTime localDateTime = new Timestamp(System.currentTimeMillis()).toLocalDateTime();
        Timestamp timestamp = Timestamp.valueOf(LocalDateTime.now());

        // LocalDate 与 java.sql.Date 的转换
        LocalDate localDate = new Date(System.currentTimeMillis()).toLocalDate();
        Date date = Date.valueOf(LocalDate.now());

        // LocalTime 与 java.sql.time 的转换
        LocalTime localTime = new Time(System.currentTimeMillis()).toLocalTime();
        Time time = Time.valueOf(LocalTime.now());

    }
}