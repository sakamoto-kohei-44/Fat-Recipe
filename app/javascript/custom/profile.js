import Chartkick from "chartkick";
import { Chart } from 'chart.js';

document.addEventListener('turbo:submit-end', async () => {
  try {
    // サーバーから最新の体重データを非同期で取得
    const response = await fetch('/path/to/weight_data_endpoint');
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }
    const newData = await response.json();

    // Chartkick グラフの更新
    const chart = Chartkick.charts["weight-chart"];
    if (chart) {
      chart.updateData(newData.map(data => [data.date, data.weight]));
    }
  } catch (error) {
    console.error('Fetch error:', error);
  }
});
