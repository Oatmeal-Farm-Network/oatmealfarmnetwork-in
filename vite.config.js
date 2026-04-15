import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import path from 'path'

export default defineConfig({
  plugins: [react()],
  server: {
    proxy: {
      '/auth': {
        target: 'http://127.0.0.1:8000',
        changeOrigin: true,
        secure: false,
      },
      '/api': {
        target: 'http://127.0.0.1:8000',
        changeOrigin: true,
        secure: false,
      },
    },
    // Don't watch the large static images folder — it has 33k+ files and
    // kills dev server startup and HMR performance.
    watch: {
      ignored: [
        '**/public/images/**',
        '**/node_modules/**',
      ],
    },
  },
});
