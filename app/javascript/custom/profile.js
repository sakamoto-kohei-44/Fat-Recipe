import Chartkick from "chartkick";
import Chart from "chart.js";

document.addEventListener('turbo:submit-end', () => {

  // グラフを取得
  const chart = document.getElementById('weight-chart')

  // 新しいデータ
  const newData = [
    {/* 日付 */},
    {/* 体重 */}
  ]

  // グラフを更新
  chart.updateData(newData)

})