// src/app/layout.tsx
import './globals.css'
import { Providers } from './providers'

export const metadata = {
  title: 'Frontend',
  description: 'Ask database questions',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">{<>
      <head />
      <body>
        <Providers>{children}</Providers>
      </body>
    </>}</html>
  )
}
