import java.util.Arrays;

/**
 * @author DF 快递排序算法 时间复杂度O(n * log(n)) 不稳定的排序 不需要额外空间 综合性能比较好，实际使用也比较多
 */
public class QuickSort {

    public static void main(String[] args) {
        // 待排序数组
        int[] x = { 9, 2, 4, 7, 3, 7, 10 };
        System.out.println(Arrays.toString(x));
        // 排序范围
        int low = 0;
        int high = x.length - 1;
        // 结果数组
        quickSort(x, low, high);
        System.out.println(Arrays.toString(x));
    }

    public static void quickSort(int[] arr, int low, int high) {
        // 校验
        if (arr == null || arr.length == 0) {
            return;
        }
        if (low >= high) {
            return;
        }
        // 挑选基准数
        // 基准数可以随意选，第一个最后一个都可以
        int middle = low + (high - low) / 2;
        int pivot = arr[middle];
        // 数组中小于等于基准数的数字放在左边，大于等于基准数的数字放在右边
        int i = low, j = high;
        while (i <= j) {
            // 找到大于基准的数
            while (arr[i] < pivot) {
                i++;
            }
            // 找到小于基准的数
            while (arr[j] > pivot) {
                j--;
            }
            // 交换后处理下一个数
            if (i <= j) {
                int temp = arr[i];
                arr[i] = arr[j];
                arr[j] = temp;
                i++;
                j--;
            }
        }
        // 根据最终i, j的位置，递归处理前半与后半数组
        if (low < j) {
            quickSort(arr, low, j);
        }
        if (high > i) {
            quickSort(arr, i, high);
        }
    }
}